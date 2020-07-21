// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

// Project imports:
import 'episode.dart';
import 'podcast.dart';

//!! DO NOT CHANGE THE ORDER OF THIS ENUM VALUES
enum DownloadState {
  queued,
  downloading,
  downloaded,
  failed,
}

class AudioFile extends Equatable {
  final Podcast podcast;
  final Episode episode;
  final String filename;
  final String storagePath;
  final DownloadState downloadState;
  final double downloadPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  AudioFile({
    @required this.episode,
    @required this.podcast,
    @required this.filename,
    @required this.storagePath,
    @required this.downloadState,
    @required this.downloadPercentage,
    @required this.createdAt,
    @required this.updatedAt,
  });

  factory AudioFile.init({
    @required Podcast podcast,
    @required Episode episode,
    @required String filename,
    @required String storagePath,
  }) {
    return AudioFile(
      podcast: podcast,
      episode: episode,
      filename: filename,
      storagePath: storagePath,
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

  String get filepath => join(storagePath, filename);

  @override
  List<Object> get props => [episode, downloadState, downloadPercentage];
}

class DownloadProgress {
  final String episodeId;
  final DownloadState downloadState;
  final double downloadPercentage;

  DownloadProgress({
    @required this.episodeId,
    @required this.downloadState,
    @required this.downloadPercentage,
  });

  bool get isDownloading => downloadState == DownloadState.downloading;

  bool get isComplete =>
      downloadState == DownloadState.failed ||
      downloadState == DownloadState.downloaded;
}
