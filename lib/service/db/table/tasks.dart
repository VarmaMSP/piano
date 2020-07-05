part of 'db.dart';

@DataClassName('TaskRow')
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get task => text().map(TaskTypeConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class TaskTypeConverter extends TypeConverter<Task, String> {
  const TaskTypeConverter();

  @override
  Task mapToDart(String fromDb) {
    return taskFromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(Task value) {
    return json.encode(value.toJson());
  }
}

extension TaskRowExtension on TaskRow {
  Task toModel() {
    return task;
  }
}

TaskRow taskRowFromModel(Task model) {
  return TaskRow(id: null, task: model);
}
