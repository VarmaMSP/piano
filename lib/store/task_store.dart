import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/task.dart';
import 'package:phenopod/service/db/db.dart';

TaskStore newTaskStore(Api api, Db db) {
  return _TaskStoreImpl(api: api, db: db);
}

abstract class TaskStore {
  Stream<Task> watchFirst();
  Future<void> deleteFirst();
  Future<void> lock();
  Future<void> unlock();
  Future<bool> isLocked();
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
  Future<void> lock() async {
    await db.preferenceDao.savePreference(
      key: TableLock.taskTableKey,
      value: PreferenceValue(
        taskTableLock: TableLock(createdAt: DateTime.now()),
      ),
    );
  }

  @override
  Future<void> unlock() async {
    await db.preferenceDao.deletePreference(TableLock.taskTableKey);
  }

  @override
  Future<bool> isLocked() async {
    final key = TableLock.taskTableKey;
    return await db.preferenceDao.watchPreference(key).first != null;
  }
}
