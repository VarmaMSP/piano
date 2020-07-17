// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/model/task.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

TaskStore newTaskStore(Api api, Db db) {
  return _TaskStoreImpl(api: api, db: db);
}

abstract class TaskStore {
  Future<void> saveTask(Task task);
  Stream<Task> watchFirst();
  Future<void> delete(int taskId);
}

class _TaskStoreImpl extends TaskStore {
  final Api api;
  final Db db;

  _TaskStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<void> saveTask(Task task) async {
    await db.taskDao.saveTask(task);
  }

  @override
  Stream<Task> watchFirst() {
    return db.taskDao.watchOldestTask().map((row) => row?.toModel());
  }

  @override
  Future<void> delete(int taskId) async {
    await db.taskDao.deleteTask(taskId);
  }
}
