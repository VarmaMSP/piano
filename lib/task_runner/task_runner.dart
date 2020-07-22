// Package imports:
import 'package:flutter/foundation.dart';
import 'package:phenopod/service/alarm_service/alarm_service.dart';

// Project imports:
import 'package:phenopod/store/store.dart';
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
  final AlarmService alarmService;
  final TaskRunnerMode mode;

  TaskRunner({
    @required this.store,
    @required this.alarmService,
    @required this.mode,
  });

  Future<void> start() async {
    await for (var task in store.task.watchFirst()) {
      if (task == null) {
        return;
      }

      final worker = task.taskType.map(
        cachePodcast: (data) => CachePodcastWorker(
          taskId: task.id,
          store: store,
          podcastId: data.podcastId,
          podcastUrlParam: data.podcastUrlParam,
        ),
        downloadEpisode: (data) => DownloadEpisodeWorker(
          taskId: task.id,
          store: store,
          episodeId: data.episodeId,
          url: data.url,
          filename: data.filename,
          storagePath: data.storagePath,
        ),
      );

      await worker.run();
    }
  }
}
