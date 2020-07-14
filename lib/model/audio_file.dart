import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:tuple/tuple.dart';

// //!! DO NOT CHANGE THE ORDER OF THIS ENUM VALUES
enum DownloadState {
  none,
  queued,
  downloading,
  failed,
  cancelled,
  paused,
  downloaded,
}

int downloadStateToInt(DownloadState downloadState) {
  return downloadState.index;
}

DownloadState downloadStateFromInt(int i) {
  return DownloadState.values[i];
}

class AudioFile extends Equatable {
  final String episodeId;
  final String url;
  final String directory;
  final String filename;
  final String taskId;
  final DownloadState downloadState;
  final double downloadPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  AudioFile({
    @required this.episodeId,
    @required this.url,
    @required this.directory,
    @required this.filename,
    @required this.taskId,
    @required this.downloadState,
    @required this.downloadPercentage,
    @required this.createdAt,
    @required this.updatedAt,
  });

  @override
  List<Object> get props => [episodeId, downloadState, downloadPercentage];
}

class DownloadProgress {
  final String taskId;
  final DownloadState downloadState;
  final double downloadPercentage;

  DownloadProgress({
    @required this.taskId,
    @required this.downloadState,
    @required this.downloadPercentage,
  });

  factory DownloadProgress.fromDownloaderUpdate(
    Tuple3<String, DownloadTaskStatus, int> m,
  ) {
    final taskId = m.item1;
    final status = m.item2;
    final percentage = m.item3;

    var state = DownloadState.none;
    if (status == DownloadTaskStatus.enqueued) {
      state = DownloadState.queued;
    } else if (status == DownloadTaskStatus.canceled) {
      state = DownloadState.cancelled;
    } else if (status == DownloadTaskStatus.complete) {
      state = DownloadState.downloaded;
    } else if (status == DownloadTaskStatus.running) {
      state = DownloadState.downloading;
    } else if (status == DownloadTaskStatus.failed) {
      state = DownloadState.failed;
    } else if (status == DownloadTaskStatus.paused) {
      state = DownloadState.paused;
    }

    return DownloadProgress(
      taskId: taskId,
      downloadState: state,
      downloadPercentage: percentage / 100,
    );
  }
}
