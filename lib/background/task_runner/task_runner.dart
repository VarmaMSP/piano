import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/store/store.dart';
import 'package:uuid/uuid.dart';

void startTaskRunner() async {
  final store = newStore(await newApi(), await newDb());
  final taskRunner = TaskRunner(store: store);

  try {
    await taskRunner.start();
  } catch (err) {
    print(err);
  } finally {
    await taskRunner.stop();
  }
}

class TaskRunner {
  final Store store;
  final String pid = Uuid().v4();

  TaskRunner({this.store});

  Future<void> start() async {
    if (!await store.task.isLocked()) {
      await store.task.aquireLock(pid);
    }
  }

  Future<void> stop() async {
    await store.task.releaseLock(pid);
  }
}
