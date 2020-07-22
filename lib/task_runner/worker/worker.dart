// Project imports:
import 'package:phenopod/store/store.dart';

// A worker should execute the given task idempotently
abstract class Worker {
  final int taskId;
  final Store store;

  Worker({this.taskId, this.store});

  Future<void> run() async {
    if (await shouldExecute()) {
      await execute();
    }
  }

  // Used to ensure idempotency
  Future<bool> shouldExecute();

  // Execute the task
  Future<void> execute();

  // For now just delete the task
  Future<void> markComplete() async {
    await store.task.delete(taskId);
  }
}
