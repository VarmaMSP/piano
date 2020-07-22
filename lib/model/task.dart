// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

//! DO NOT CHANGE THE ORDER
// Currently all completed tasks are deleted and The status
// completed is currently not in use.
enum TaskStatus {
  queued,
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

@freezed
abstract class TaskType with _$TaskType {
  const factory TaskType.cachePodcast({
    @required String podcastId,
    @required String podcastUrlParam,
  }) = _CachePodcast;

  const factory TaskType.downloadEpisode({
    @required String episodeId,
    @required String url,
    @required String filename,
    @required String storagePath,
  }) = _DownloadEpisode;

  factory TaskType.fromJson(Map<String, dynamic> json) =>
      _$TaskTypeFromJson(json);
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
      taskStatus: TaskStatus.queued,
      taskPriority: TaskPriority.high,
      canRetry: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
