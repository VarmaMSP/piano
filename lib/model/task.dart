// Package imports:
import 'package:equatable/equatable.dart';
import 'package:super_enum/super_enum.dart';

part 'task.g.dart';

//! DO NOT CHANGE THE ORDER
@superEnum
enum _TaskType {
  @Data(fields: [
    DataField<String>('podcastId'),
    DataField<String>('podcastUrlParam'),
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

//! DO NOT CHANGE THE ORDER
enum TaskPriority {
  /// Reserved for interrupts that need to be run right
  /// away as they effect execution of other task
  ///   Ex: canceling / pausing file download
  highest,

  /// Reserved for tasks that are initiated by user to
  /// run in the background
  ///   Ex: downloading a file
  high,

  /// Reserved for tasks that are initiated by the application
  medium,

  /// Yet to be decided
  low,
}

class Task {
  final int id;
  final TaskType taskType;
  final TaskStatus taskStatus;
  final TaskPriority taskPriority;
  final bool canRetry;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    @required this.id,
    @required this.taskType,
    @required this.taskStatus,
    @required this.taskPriority,
    @required this.canRetry,
    @required this.createdAt,
    @required this.updatedAt,
  });

  factory Task.init({TaskType taskType}) {
    return Task(
      id: null,
      taskType: taskType,
      taskStatus: TaskStatus.pending,
      taskPriority: TaskPriority.high,
      canRetry: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

//ignore: missing_return
TaskType taskTypeFromJson(Map<String, dynamic> json) {
  final key = _TaskType.values[json['key']];

  switch (key) {
    case _TaskType.CachePodcast:
      return TaskType.cachePodcast(
        podcastId: json['podcast_id'],
        podcastUrlParam: json['podcast_url_param'],
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
          'podcast_id': data.podcastId,
          'podcast_url_param': data.podcastUrlParam,
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
