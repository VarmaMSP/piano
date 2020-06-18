part of '../sqldb.dart';

@UseDao(tables: [Podcasts, Episodes, AudioTracks, AudioPlayerSnapshots])
class AudioPlayerDao extends DatabaseAccessor<SqlDb>
    with _$AudioPlayerDaoMixin {
  AudioPlayerDao(SqlDb db) : super(db);

  Future<void> saveAudioPlayerSnapshot(AudioPlayerSnapshot snapshot) async {
    await transaction(() async {
      /// Insert AudioTracks
      if (snapshot.queue.audioTracks.isNotEmpty) {
        await batch((b) {
          b.insertAll(
            podcasts,
            snapshot.queue.audioTracks
                .map((e) => podcastRowFromModel(e.podcast))
                .toList(),
            mode: InsertMode.insertOrIgnore,
          );
        });

        await batch((b) {
          b.insertAll(
            episodes,
            snapshot.queue.audioTracks
                .map((e) => episodeRowFromModel(e.episode))
                .toList(),
            mode: InsertMode.insertOrIgnore,
          );
        });

        await batch((b) {
          b.insertAll(
            audioTracks,
            snapshot.queue.audioTracks
                .map((e) => audioTrackRowFromModel(e))
                .toList(),
            mode: InsertMode.insertOrReplace,
          );
        });
      }

      /// Delete any additional audio tracks
      await (delete(audioTracks)
            ..where(
              (tbl) => tbl.position.isBiggerOrEqualValue(
                snapshot.queue.audioTracks.length,
              ),
            ))
          .go();

      /// Update snapshot
      await into(audioPlayerSnapshots).insert(
        audioPlayerSnapshotRowFromModel(snapshot),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Stream<AudioPlayerSnapshot> getAudioPlayerSnapshot() {
    return Rx.combineLatest2<AudioPlayerSnapshotRow, List<AudioTrack>,
        AudioPlayerSnapshot>(
      (select(audioPlayerSnapshots)..where((tbl) => tbl.id.equals(0)))
          .watchSingle(),
      (select(audioTracks)
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
              final audioTrack = row.readTable(audioTracks);
              final episode = row.readTable(episodes);
              final podcast = row.readTable(podcasts);

              return AudioTrack(
                episode: episode.toModel(),
                podcast: podcast.toModel(),
                position: audioTrack.position,
              );
            }).toList(),
          ),
      (snapshotRow, tracks) => snapshotRow == null
          ? null
          : AudioPlayerSnapshot(
              queue: Queue(
                audioTracks: tracks ?? [],
                position: snapshotRow.queuePosition,
                enabled: snapshotRow.queueEnabled,
              ),
            ),
    );
  }
}
