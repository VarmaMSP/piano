import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/task.dart';
import 'package:phenopod/service/db/db.dart';

TaskStore newTaskStore(Api api, Db db) {
  return _TaskStoreImpl(api: api, db: db);
}

abstract class TaskStore {
  Stream<Task> watchFirst();
  Future<void> deleteFirst();
}

class _TaskStoreImpl extends TaskStore {
  final Api api;
  final Db db;

  _TaskStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Stream<Task> watchFirst() {
    return db.taskDao.watchOldestTask().map((row) => row?.task);
  }

  @override
  Future<void> deleteFirst() async {
    final oldestTask = await db.taskDao.watchOldestTask().first;
    if (oldestTask != null) {
      await db.taskDao.deleteTask(oldestTask.id);
    }
  }
}