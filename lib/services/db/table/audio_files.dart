part of '../db.dart';

@DataClassName('AudioFileRow')
class AudioFiles extends Table {
  TextColumn get episodeId =>
      text().customConstraint('REFERENCES episodes(id)')();
  TextColumn get url => text()();
  TextColumn get filename => text()();
  TextColumn get storagePath => text()();
  IntColumn get downloadState => integer().map(DownloadStateConverter())();
  RealColumn get downloadPercentage => real()();
  IntColumn get downloadTaskId => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {episodeId};
}

class DownloadStateConverter extends TypeConverter<DownloadState, int> {
  const DownloadStateConverter();

  @override
  DownloadState mapToDart(int fromDb) {
    return DownloadState.values[fromDb];
  }

  @override
  int mapToSql(DownloadState value) {
    return value.index;
  }
}

AudioFileRow audioFileRowFromModel(AudioFile model) {
  return AudioFileRow(
    episodeId: model.episode.id,
    url: model.episode.mediaUrl,
    filename: model.filename,
    storagePath: model.storagePath,
    downloadState: model.downloadState,
    downloadPercentage: model.downloadPercentage,
    downloadTaskId: model.downloadTaskId,
    createdAt: model.createdAt ?? DateTime.now(),
    updatedAt: model.updatedAt ?? DateTime.now(),
  );
}

extension AudioFileRowExtension on AudioFileRow {
  AudioFile toModel(Episode episode, Podcast podcast) {
    return AudioFile(
      episode: episode,
      podcast: podcast,
      filename: filename,
      storagePath: storagePath,
      downloadState: downloadState,
      downloadPercentage: downloadPercentage,
      downloadTaskId: downloadTaskId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
