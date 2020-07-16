part of '../db.dart';

@DataClassName('TaskRow')
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskType => text().map(TaskTypeConverter())();
  IntColumn get taskStatus => integer().map(TaskStatusConverter())();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class TaskTypeConverter extends TypeConverter<TaskType, String> {
  const TaskTypeConverter();

  @override
  TaskType mapToDart(String fromDb) {
    return taskTypeFromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(TaskType value) {
    return json.encode(value.toJson());
  }
}

class TaskStatusConverter extends TypeConverter<TaskStatus, int> {
  const TaskStatusConverter();

  @override
  TaskStatus mapToDart(int fromDb) {
    return TaskStatus.values[fromDb];
  }

  @override
  int mapToSql(TaskStatus value) {
    return value.index;
  }
}

TaskRow taskRowFromModel(Task model) {
  return TaskRow(
    id: model.id,
    taskType: model.taskType,
    taskStatus: model.taskStatus,
    createdAt: model.createdAt,
    updatedAt: model.updatedAt,
  );
}

extension TaskRowExtension on TaskRow {
  Task toModel() {
    return Task(
      id: id,
      taskType: taskType,
      taskStatus: taskStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
