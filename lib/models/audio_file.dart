part of 'main.dart';

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
  final int downloadTaskId;
  final DateTime createdAt;
  final DateTime updatedAt;

  AudioFile({
    @required this.episode,
    @required this.podcast,
    @required this.filename,
    @required this.storagePath,
    @required this.downloadState,
    @required this.downloadPercentage,
    @required this.downloadTaskId,
    @required this.createdAt,
    @required this.updatedAt,
  });

  factory AudioFile.init({
    @required Podcast podcast,
    @required Episode episode,
    @required String filename,
    @required String storagePath,
    @required int downloadTaskId,
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
      downloadTaskId: downloadTaskId,
    );
  }

  bool get isQueued => downloadState == DownloadState.queued;

  bool get isDownloading => downloadState == DownloadState.downloading;

  bool get isComplete =>
      downloadState == DownloadState.failed ||
      downloadState == DownloadState.downloaded;

  String get filepath => join(storagePath, filename);

  DownloadProgress get downloadProgress => DownloadProgress(
        episodeId: episode.id,
        downloadState: downloadState,
        downloadPercentage: downloadPercentage,
      );

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
