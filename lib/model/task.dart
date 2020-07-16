import 'package:super_enum/super_enum.dart';
import 'package:equatable/equatable.dart';

part 'task.g.dart';

//! DO NOT CHANGE THE ORDER
@superEnum
enum _TaskType {
  @Data(fields: [
    DataField<String>('urlParam'),
  ])
  CachePodcast,
  @Data(fields: [
    DataField<String>('episodeId'),
    DataField<String>('url'),
    DataField<String>('filepath'),
  ])
  DownloadEpisode,
}

//! DO NOT CHANGE THE ORDER
enum TaskStatus {
  pending,
  completed,
  failed,
}

class Task {
  final int id;
  final TaskType taskType;
  final TaskStatus taskStatus;
  final bool canRetry;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    @required this.id,
    @required this.taskType,
    @required this.taskStatus,
    @required this.canRetry,
    @required this.createdAt,
    @required this.updatedAt,
  });
}

//ignore: missing_return
TaskType taskTypeFromJson(Map<String, dynamic> json) {
  final key = _TaskType.values[json['key']];

  switch (key) {
    case _TaskType.CachePodcast:
      return TaskType.cachePodcast(
        urlParam: json['url_param'],
      );

    case _TaskType.DownloadEpisode:
      return TaskType.downloadEpisode(
        episodeId: json['episode_id'],
        url: json['url'],
        filepath: json['filepath'],
      );
  }
}

extension TaskTypeExtension on TaskType {
  Map<String, dynamic> toJson() {
    return when(
      cachePodcast: (data) {
        return {
          'key': _TaskType.CachePodcast.index,
          'url_param': data.urlParam,
        };
      },
      downloadEpisode: (data) {
        return {
          'key': _TaskType.DownloadEpisode.index,
          'episode_id': data.episodeId,
          'url': data.url,
          'filepath': data.filepath,
        };
      },
    );
  }
}
