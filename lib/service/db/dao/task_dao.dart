part of '../db.dart';

@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<SqlDb> with _$TaskDaoMixin {
  TaskDao(SqlDb db) : super(db);

  Future<void> saveTask(Task task) {
    return into(tasks)
        .insert(taskRowFromModel(task), mode: InsertMode.insertOrReplace);
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
