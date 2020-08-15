// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/db/db.dart';
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
    } catch (err) {
      print('Worker Error: ${err}');
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
