part of '../sqldb.dart';

@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<SqlDb> with _$TaskDaoMixin {
  TaskDao(SqlDb db) : super(db);

  Future<void> saveTasks(List<Task> tasks_) {
    return batch((b) {
      b.insertAll(tasks, tasks_.map((t) => taskRowFromModel(t)).toList());
    });
  }

  Stream<TaskRow> watchOldestTask() {
    return (select(tasks)
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.id)])
          ..limit(1))
        .watchSingle();
  }

  Future<void> deleteTask(int id) {
    return (delete(tasks)..where((tbl) => tbl.id.equals(id))).go();
  }
}
