part of '../db.dart';

@DataClassName('AudioFileRow')
class AudioFiles extends Table {
  TextColumn get episodeId =>
      text().customConstraint('REFERENCES episodes(id)')();
  TextColumn get url => text()();
  TextColumn get directory => text()();
  TextColumn get filename => text()();
  IntColumn get downloadState => integer()();
  IntColumn get downloadPercentage => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {episodeId};
}

AudioFileRow audioFileRowFromModel(AudioFile model) {
  return AudioFileRow(
    episodeId: model.episodeId,
    url: model.url,
    directory: model.directory,
    filename: model.filename,
    downloadState: downloadStateToInt(model.downloadState),
    downloadPercentage: model.downloadPercentage,
    createdAt: model.createdAt ?? DateTime.now(),
    updatedAt: model.updatedAt ?? DateTime.now(),
  );
}

extension AudioFileRowExtension on AudioFileRow {
  AudioFile toModel() {
    return AudioFile(
      episodeId: episodeId,
      url: this.url,
      directory: directory,
      filename: filename,
      downloadState: downloadStateFromInt(downloadState),
      downloadPercentage: downloadPercentage,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
