// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

// Project imports:
import 'package:phenopod/store/store.dart';

// A worker should execute the given task idempotently
abstract class Worker {
  final int taskId;
  final Db db;
  final Api api;
  final Store store;

  Worker({
    @required this.taskId,
    @required this.db,
    @required this.api,
    @required this.store,
  });

  Future<void> run() async {
    try {
      await shouldExecute() ? await execute() : await deleteTask();
    } finally {
      await dispose();
    }
  }

  // Used to ensure idempotency
  Future<bool> shouldExecute();

  // Execute the task
  Future<void> execute();

  // Dispose any resources
  Future<void> dispose();

  // Deletes tasks premanently
  Future<void> deleteTask() async {
    await store.task.delete(taskId);
  }
}
