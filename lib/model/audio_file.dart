// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

// Project imports:
import 'episode.dart';

//!! DO NOT CHANGE THE ORDER OF THIS ENUM VALUES
enum DownloadState {
  queued,
  downloading,
  downloaded,
  failed,
}

class AudioFile extends Equatable {
  final String episodeId;
  final String url;
  final String directory;
  final String filename;
  final DownloadState downloadState;
  final double downloadPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  AudioFile({
    @required this.episodeId,
    @required this.url,
    @required this.directory,
    @required this.filename,
    @required this.downloadState,
    @required this.downloadPercentage,
    @required this.createdAt,
    @required this.updatedAt,
  });

  factory AudioFile.init({
    @required Episode episode,
    @required String directory,
    @required String filename,
  }) {
    return AudioFile(
      episodeId: episode.id,
      url: episode.mediaUrl,
      directory: directory,
      filename: filename,
      downloadState: DownloadState.queued,
      downloadPercentage: 0.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  bool get isDownloading => downloadState == DownloadState.downloading;

  bool get isComplete =>
      downloadState == DownloadState.failed ||
      downloadState == DownloadState.downloaded;

  String get filepath => join(directory, filename);

  @override
  List<Object> get props => [episodeId, url, downloadState, downloadPercentage];
}

class DownloadProgress {
  final String episodeId;
  final DownloadState downloadState;
  final double downloadPercentage;

  DownloadProgress({
    this.episodeId,
    this.downloadState,
    this.downloadPercentage,
  });
}
