part of '../db.dart';

@UseDao(tables: [
  Podcasts,
  Episodes,
  AudioTracks,
])
class AudioTrackDao extends DatabaseAccessor<SqlDb> with _$AudioTrackDaoMixin {
  AudioTrackDao(SqlDb db) : super(db);

  Future<void> saveTracks(List<AudioTrack> tracks) {
    return batch((b) {
      b.insertAll(
        audioTracks,
        tracks.map(audioTrackRowFromModel).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Stream<List<AudioTrack>> watchAllTracks() {
    return (select(audioTracks)
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.position),
          ]))
        .join([
          innerJoin(episodes, episodes.id.equalsExp(audioTracks.episodeId)),
          innerJoin(podcasts, podcasts.id.equalsExp(episodes.podcastId)),
        ])
        .watch()
        .map(
          (rows) => rows.map((row) {
            final audioTrackRow = row.readTable(audioTracks);
            final episodeRow = row.readTable(episodes);
            final podcastRow = row.readTable(podcasts);

            return AudioTrack(
              episode: episodeRow.toModel(),
              podcast: podcastRow.toModel(),
              position: audioTrackRow.position,
            );
          }).toList(),
        );
  }

  Future<AudioTrack> getTrackByPosition(int pos) async {
    final row = await (select(audioTracks)
          ..where((tbl) => tbl.position.equals(pos)))
        .join([
      innerJoin(episodes, episodes.id.equalsExp(audioTracks.episodeId)),
      innerJoin(podcasts, podcasts.id.equalsExp(episodes.podcastId)),
    ]).getSingle();

    final audioTrackRow = row.readTable(audioTracks);
    final episodeRow = row.readTable(episodes);
    final podcastRow = row.readTable(podcasts);
    return AudioTrack(
      episode: episodeRow.toModel(),
      podcast: podcastRow.toModel(),
      position: audioTrackRow.position,
    );
  }

  Future<void> deleteAllTracks() {
    return delete(audioTracks).go();
  }

  Future<void> deleteTracksNotInQueue(int queueLength) {
    return (delete(audioTracks)
          ..where((tbl) => tbl.position.isBiggerOrEqualValue(queueLength)))
        .go();
  }
}
