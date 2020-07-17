part of '../db.dart';

@UseDao(tables: [AudioFiles])
class AudioFileDao extends DatabaseAccessor<SqlDb> with _$AudioFileDaoMixin {
  AudioFileDao(SqlDb db) : super(db);

  Future<void> save(AudioFile audioFile) async {
    await into(audioFiles).insert(
      audioFileRowFromModel(audioFile),
      mode: InsertMode.insertOrReplace,
    );
  }

  Stream<AudioFile> watchByEpisode(String episodeId) {
    return (select(audioFiles)..where((tbl) => tbl.episodeId.equals(episodeId)))
        .watchSingle()
        .map((row) => row?.toModel());
  }

  Future<void> updateProgress(DownloadProgress progress) async {
    await (update(audioFiles)
          ..where((tbl) => tbl.episodeId.equals(progress.episodeId)))
        .write(
      AudioFilesCompanion(
        downloadState: Value(progress.downloadState),
        downloadPercentage: Value(progress.downloadPercentage),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteByEpisode(String episodeId) async {
    await (delete(audioFiles)..where((tbl) => tbl.episodeId.equals(episodeId)))
        .go();
  }
}
