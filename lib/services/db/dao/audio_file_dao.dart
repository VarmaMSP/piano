part of '../db.dart';

@UseDao(tables: [AudioFiles, Episodes, Podcasts])
class AudioFileDao extends DatabaseAccessor<SqlDb> with _$AudioFileDaoMixin {
  AudioFileDao(SqlDb db) : super(db);

  Future<void> save(AudioFile audioFile) async {
    await into(audioFiles).insert(
      audioFileRowFromModel(audioFile),
      mode: InsertMode.insertOrReplace,
    );
  }

  Stream<AudioFile> watchFileByEpisode(String episodeId) {
    return (select(audioFiles)..where((tbl) => tbl.episodeId.equals(episodeId)))
        .join([
          innerJoin(episodes, episodes.id.equalsExp(audioFiles.episodeId)),
          innerJoin(podcasts, podcasts.id.equalsExp(episodes.podcastId)),
        ])
        .watchSingle()
        .map(
          (row) {
            if (row == null) {
              return null;
            }

            final audioFileRow = row.readTable(audioFiles);
            final episodeRow = row.readTable(episodes);
            final podcastRow = row.readTable(podcasts);
            return audioFileRow.toModel(
              episodeRow.toModel(),
              podcastRow.toModel(),
            );
          },
        );
  }

  Stream<List<AudioFile>> watchAllFiles() {
    return (select(audioFiles)
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.createdAt),
          ]))
        .join([
          innerJoin(episodes, episodes.id.equalsExp(audioFiles.episodeId)),
          innerJoin(podcasts, podcasts.id.equalsExp(episodes.podcastId)),
        ])
        .watch()
        .map(
          (rows) => rows.map((row) {
            final audioFileRow = row.readTable(audioFiles);
            final episodeRow = row.readTable(episodes);
            final podcastRow = row.readTable(podcasts);

            return audioFileRow.toModel(
              episodeRow.toModel(),
              podcastRow.toModel(),
            );
          }).toList(),
        );
  }

  Stream<DownloadProgress> watchProgressByEpisode(String episodeId) {
    return (select(audioFiles)..where((tbl) => tbl.episodeId.equals(episodeId)))
        .watchSingle()
        .map(
          (audioFile) => audioFile == null
              ? null
              : DownloadProgress(
                  episodeId: audioFile.episodeId,
                  downloadState: audioFile.downloadState,
                  downloadPercentage: audioFile.downloadPercentage,
                ),
        );
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
