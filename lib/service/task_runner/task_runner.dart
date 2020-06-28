import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';

import 'worker/cache_podcast_to_db.dart';

class TaskRunner {
  final Store store;

  TaskRunner({this.store});

  void init() {
    store.taskQueue.watchFront().where((task) => task != null).listen(_runTask);
  }

  Future<void> _runTask(Task task) async {
    await task.when(
      cachePodcastToDb: (data) => CachePodcastToDbWorker(
        store: store,
        urlParam: data.urlParam,
      ).run(),
    );
    await store.taskQueue.pop();
  }
}
