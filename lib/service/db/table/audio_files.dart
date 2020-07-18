part of '../db.dart';

@DataClassName('AudioFileRow')
class AudioFiles extends Table {
  TextColumn get episodeId =>
      text().customConstraint('REFERENCES episodes(id)')();
  TextColumn get url => text()();
  TextColumn get directory => text()();
  TextColumn get filename => text()();
  IntColumn get downloadState => integer().map(DownloadStateConverter())();
  RealColumn get downloadPercentage => real()();
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
    directory: model.directory,
    filename: model.filename,
    downloadState: model.downloadState,
    downloadPercentage: model.downloadPercentage,
    createdAt: model.createdAt ?? DateTime.now(),
    updatedAt: model.updatedAt ?? DateTime.now(),
  );
}

extension AudioFileRowExtension on AudioFileRow {
  AudioFile toModel(Episode episode, Podcast podcast) {
    return AudioFile(
      episode: episode,
      podcast: podcast,
      directory: directory,
      filename: filename,
      downloadState: downloadState,
      downloadPercentage: downloadPercentage,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
