import 'package:phenopod/model/task.dart';
import 'package:phenopod/store/store.dart';

import 'db.dart';

class TaskQueueDb extends TaskQueueStore {
  final Db db;

  TaskQueueDb({this.db});

  @override
  Future<void> pop() async {
    final oldestTask = await db.taskDao.watchOldestTask().first;
    await db.taskDao.deleteTask(oldestTask.id);
  }

  @override
  Stream<Task> watchFront() {
    return db.taskDao.watchOldestTask().map((row) => row?.task);
  }
}
