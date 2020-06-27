import 'package:super_enum/super_enum.dart';

part 'task.g.dart';

@superEnum
enum _TaskFunction {
  @Data(fields: [DataField<String>('urlParam')])
  SavePodcastToDb,
  @object
  Invalid,
}

enum TaskStatus {
  ready,
  enqueued,
  running,
  failed,
  invalid,
}

class Task {
  final int id;
  final TaskFunction func;
  final TaskStatus status;
  final DateTime lastUpdated;

  Task({this.id, this.func, this.status, this.lastUpdated});
}
