import 'package:super_enum/super_enum.dart';

part 'task.g.dart';

/// Every task should be idempotent
@superEnum
enum _Task {
  @Data(fields: [DataField<String>('urlParam')])
  CachePodcastToDb,
}

extension TaskExtension on Task {
  Map<String, dynamic> toJson() {
    return when(
      cachePodcastToDb: (data) {
        return {
          'key': _Task.CachePodcastToDb.index,
          'url_param': data.urlParam,
        };
      },
    );
  }
}

//ignore: missing_return
Task taskFromJson(Map<String, dynamic> json) {
  switch (_Task.values[json['key']]) {
    case _Task.CachePodcastToDb:
      return Task.cachePodcastToDb(urlParam: json['url_param']);
  }
}
