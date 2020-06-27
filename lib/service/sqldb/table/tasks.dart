part of '../sqldb.dart';

@DataClassName('TaskRow')
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get func =>
      text().map(TaskFunctionTypeConverter()).customConstraint('UNIQUE')();
  TextColumn get status => text()();
  DateTimeColumn get lastUpdated => dateTime()();
}

class TaskFunctionTypeConverter extends TypeConverter<TaskFunction, String> {
  const TaskFunctionTypeConverter();

  @override
  TaskFunction mapToDart(String fromDb) {
    final j = json.decode(fromDb) as Map<String, String> ?? {};
    switch (j['name']) {
      case 'save_podcast_to_db':
        return TaskFunction.savePodcastToDb(urlParam: j['url_param']);
      default:
        return TaskFunction.invalid();
    }
  }

  @override
  String mapToSql(TaskFunction value) {
    return json.encode(value.when(
      savePodcastToDb: (data) => {
        'name': 'save_podcast_to_db',
        'url_param': data.urlParam,
      },
      invalid: (data) => {'name': 'invalid'},
    ));
  }
}

TaskStatus taskStatusFromString(String fromDb) {
  switch (fromDb) {
    case 'ready':
      return TaskStatus.ready;
    case 'enqueued':
      return TaskStatus.enqueued;
    case 'running':
      return TaskStatus.running;
    case 'failed':
      return TaskStatus.failed;
    default:
      return TaskStatus.invalid;
  }
}

String taskStatusToString(TaskStatus value) {
  switch (value) {
    case TaskStatus.ready:
      return 'ready';
    case TaskStatus.enqueued:
      return 'enqueued';
    case TaskStatus.running:
      return 'running';
    case TaskStatus.failed:
      return 'failed';
    default:
      return 'invalid';
  }
}

TaskRow taskRowFromModel(Task model) {
  return TaskRow(
    id: null,
    func: model.func,
    status: taskStatusToString(model.status),
    lastUpdated: model.lastUpdated,
  );
}

extension TaskRowExtension on TaskRow {
  Task toModel() {
    return Task(
      id: id,
      func: func,
      status: taskStatusFromString(status),
      lastUpdated: lastUpdated,
    );
  }
}
