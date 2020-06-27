part of '../sqldb.dart';

@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<SqlDb> with _$TaskDaoMixin {
  TaskDao(SqlDb db) : super(db);

  Future<void> saveTask(Task task) async {
    await into(tasks)
        .insert(taskRowFromModel(task), mode: InsertMode.insertOrReplace);
  }

  Stream<List<Task>> watchReadyTasks() {
    final statusStr = taskStatusToString(TaskStatus.ready);
    return (select(tasks)..where((tbl) => tbl.status.equals(statusStr)))
        .watch()
        .map((xs) => xs.map((x) => x.toModel()));
  }

  Future<void> setTaskStatus(List<int> taskIds, TaskStatus status) async {
    final statusStr = taskStatusToString(status);
    await (update(tasks)..where((tbl) => tbl.id.isIn(taskIds)))
        .write(TasksCompanion(status: Value(statusStr)));
  }

  Future<void> deleteTask(int taskId) async {
    await (delete(tasks)..where((tbl) => tbl.id.equals(taskId))).go();
  }
}
