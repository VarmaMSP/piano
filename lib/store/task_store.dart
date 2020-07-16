import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/task.dart';
import 'package:phenopod/service/db/db.dart';

TaskStore newTaskStore(Api api, Db db) {
  return _TaskStoreImpl(api: api, db: db);
}

abstract class TaskStore {
  Future<void> saveTask(Task task);
  Stream<Task> watchFirst();
  Future<void> deleteFirst();

  Future<bool> isLocked();
  Future<void> aquireLock(String pid);
  Future<void> releaseLock(String pid);
}

class _TaskStoreImpl extends TaskStore {
  final Api api;
  final Db db;

  _TaskStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<void> saveTask(Task task) async {}

  @override
  Stream<Task> watchFirst() {
    return db.taskDao.watchOldestTask().map((row) => row?.toModel());
  }

  @override
  Future<void> deleteFirst() async {
    final oldestTask = await db.taskDao.watchOldestTask().first;
    if (oldestTask != null) {
      await db.taskDao.deleteTask(oldestTask.id);
    }
  }

  @override
  Future<bool> isLocked() async {
    final key = TableLock.taskTableKey;
    final val = await db.preferenceDao.watchPreference(key).first;
    return val?.taskTableLock != null;
  }

  @override
  Future<void> aquireLock(String pid) async {
    await db.preferenceDao.savePreference(
      key: TableLock.taskTableKey,
      value: PreferenceValue(
        taskTableLock: TableLock(
          pid: pid,
          createdAt: DateTime.now(),
        ),
      ),
    );
  }

  @override
  Future<void> releaseLock(String pid) async {
    final key = TableLock.taskTableKey;
    final val = await db.preferenceDao.watchPreference(key).first;
    final lock = val?.taskTableLock;

    if (lock != null && lock.pid == pid) {
      await db.preferenceDao.deletePreference(key);
    }
  }
}
