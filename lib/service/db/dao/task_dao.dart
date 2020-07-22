part of '../db.dart';

@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<SqlDb> with _$TaskDaoMixin {
  TaskDao(SqlDb db) : super(db);

  Future<void> saveTask(Task task) {
    return into(tasks)
        .insert(taskRowFromModel(task), mode: InsertMode.insertOrReplace);
  }

  Stream<Task> watchTaskById(int id) {
    return (select(tasks)..where((tbl) => tbl.id.equals(id)))
        .watchSingle()
        .map((e) => e?.toModel());
  }

  Stream<Task> watchOldestTask({@required TaskStatus taskStatus}) {
    return (select(tasks)
          ..where((tbl) => tbl.taskStatus.equals(taskStatus.index))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.id)])
          ..limit(1))
        .watchSingle()
        .map((e) => e?.toModel());
  }

  Future<void> deleteTask(int id) {
    return (delete(tasks)..where((tbl) => tbl.id.equals(id))).go();
  }
}
