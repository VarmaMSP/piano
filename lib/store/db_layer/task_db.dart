import 'package:phenopod/model/task.dart';
import 'package:phenopod/store/store.dart';

import 'db.dart';

class TaskDb extends TaskStore {
  final Db db;

  TaskDb({this.db});

  @override
  Future<void> save(Task task) {
    return db.taskDao.saveTask(task);
  }

  @override
  Stream<List<Task>> watchReady() {
    return db.taskDao.watchReadyTasks();
  }

  @override
  Future<void> setStatus(List<int> taskIds, TaskStatus status) {
    return db.taskDao.setTaskStatus(taskIds, status);
  }

  @override
  Future<void> delete(int taskId) {
    return db.taskDao.deleteTask(taskId);
  }
}
