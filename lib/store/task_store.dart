// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/alarm_service/alarm_service.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

TaskStore newTaskStore(Api api, Db db, [AlarmService alarmService]) {
  return _TaskStoreImpl(api: api, db: db, alarmService: alarmService);
}

abstract class TaskStore {
  Future<void> saveTask(Task task);
  Stream<Task> watchById(int id);
  Stream<Task> watchQueueTop();
  Future<void> delete(int taskId);
}

class _TaskStoreImpl extends TaskStore {
  final Api api;
  final Db db;
  final AlarmService alarmService;

  _TaskStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
  });

  @override
  Future<void> saveTask(Task task) async {
    await db.taskDao.saveTask(task);
  }

  @override
  Stream<Task> watchById(int id) {
    return db.taskDao.watchTaskById(id);
  }

  @override
  Stream<Task> watchQueueTop() {
    return db.taskDao.watchOldestTask(taskStatus: TaskStatus.queued);
  }

  @override
  Future<void> delete(int taskId) async {
    await db.taskDao.deleteTask(taskId);
  }
}
