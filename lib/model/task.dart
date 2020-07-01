import 'package:super_enum/super_enum.dart';

part 'task.g.dart';

/// Every task should be idempotent
@superEnum
enum _Task {
  @Data(fields: [DataField<String>('urlParam')])
  CachePodcast,
}

extension TaskExtension on Task {
  Map<String, dynamic> toJson() {
    return when(
      cachePodcast: (data) {
        return {
          'key': _Task.CachePodcast.index,
          'url_param': data.urlParam,
        };
      },
    );
  }
}

//ignore: missing_return
Task taskFromJson(Map<String, dynamic> json) {
  switch (_Task.values[json['key']]) {
    case _Task.CachePodcast:
      return Task.cachePodcast(urlParam: json['url_param']);
  }
}
