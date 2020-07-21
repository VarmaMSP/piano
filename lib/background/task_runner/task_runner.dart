// Package imports:
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:phenopod/background/task_runner/worker/download_episode_worker.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/store/store.dart';
import 'worker/cache_podcast_worker.dart';

Store store;
bool _isRunning = false;

void startTaskRunner() async {
  store ??= newStore(await newApi(), await newDb());

  if (!_isRunning) {
    _isRunning = true;

    try {
      await TaskRunner(store: store).start();
    } catch (err) {
      print(err);
    } finally {
      _isRunning = false;
    }
  }
}

class TaskRunner {
  final Store store;
  final String pid = Uuid().v4();

  TaskRunner({this.store});

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
