import 'dart:async';

import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:rxdart/rxdart.dart';

class TaskRunner {
  final Store store;
  final BehaviorSubject<Task> _taskSubject = BehaviorSubject<Task>();

  TaskRunner({this.store}) {
    /// pipe ready tasks from db to taskSubject
    store.task.watchReady().listen((tasks) async {
      tasks.forEach(_taskSubject.add);
      await store.task.setStatus(tasks.map((x) => x.id), TaskStatus.enqueued);
    });

    /// Run new tasks
    _taskSubject.stream.asyncMap(_runTask);
  }

  Future<void> _runTask(Task task) async {
    await store.task.setStatus([task.id], TaskStatus.running);
    try {
      await task.func.when(
        savePodcastToDb: (data) => savePodcastToDb(store, data.urlParam),
        invalid: (_) => null,
      );
      await store.task.delete(task.id);
    } catch (err) {
      await store.task.setStatus([task.id], TaskStatus.failed);
    }
  }
}

Future<void> savePodcastToDb(Store store, String podcastUrlParam) async {
  // final screenData = await store.podcast.getScreenData(podcastUrlParam);
  // final podcast = await store
}
