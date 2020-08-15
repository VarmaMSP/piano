// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:when_expression/when_expression.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/alarm_service/alarm_service.dart';
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/db/db.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/stream.dart' as stream_utils;
import 'worker/cache_podcast_worker.dart';
import 'worker/download_episode_worker.dart';

//! DO NOT CHANGE ORDER
enum TaskRunnerMode {
  // In foreground mode task runner will long poll for new tasks
  // to process. Taskrunner is intended to be invoked in this mode
  // when the app is active.
  foreground,
  // In foreground mode task runner will stop once all task in
  // the queue are processed.
  background,
}

class TaskRunner {
  final Store store;
  final Db db;
  final Api api;
  final AlarmService alarmService;
  final TaskRunnerMode mode;

  TaskRunner({
    @required this.db,
    @required this.api,
    @required this.alarmService,
    @required this.mode,
  }) : store = newStoreForBackground(api, db);

  Future<void> start() async {
    await Future.wait([
      startExecutor(TaskPriority.high),
      startExecutor(TaskPriority.medium),
    ]);
  }

  Future<void> startExecutor(TaskPriority taskPriority) async {
    final queuedTasks = stream_utils.StreamLongPoll(
      store.task.watchQueueTop(taskPriority),
      waitDuration: when<TaskRunnerMode, Duration>({
        (v) => v == TaskRunnerMode.foreground: (_) => Duration(minutes: 20),
        (v) => v == TaskRunnerMode.background: (_) => Duration.zero,
      })(mode),
    ).stream;

    await for (var task in queuedTasks) {
      await task.taskType
          .map(
            cachePodcast: (data) => CachePodcastWorker(
              taskId: task.id,
              db: db,
              api: api,
              store: store,
              podcastId: data.podcastId,
              podcastUrlParam: data.podcastUrlParam,
            ),
            downloadEpisode: (data) => DownloadEpisodeWorker(
              taskId: task.id,
              db: db,
              api: api,
              store: store,
              episodeId: data.episodeId,
              url: data.url,
              filename: data.filename,
              storagePath: data.storagePath,
            ),
          )
          .run();

      // Incase where app is closed with tasks still to be executed, we need them
      // to be run by taskrunner in background some time later. We achieve this by
      // repeatedly rescheduling taskrunner to run some time in future.
      if (mode == TaskRunnerMode.foreground) {
        await alarmService.scheduleTaskRunner(mode: TaskRunnerMode.background);
      }
    }
  }
}
