abstract class Worker {
  /// Returns false if the task is already executed
  Future<bool> shouldExecute();

  Future<void> execute();

  Future<void> run() async {
    if (await shouldExecute()) {
      await execute();
    }
  }
}
