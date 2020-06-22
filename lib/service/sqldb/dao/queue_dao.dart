part of '../sqldb.dart';

@UseDao(tables: [
  Podcasts,
  Episodes,
  AudioTracks,
  Preferences,
])
class QueueDao extends DatabaseAccessor<SqlDb> with _$QueueDaoMixin {
  QueueDao(SqlDb db) : super(db);

  Future<void> saveQueue(Queue queue) async {
    if (queue.isEmpty) {
      await transaction(() async {
        //Clear all audio tracks
        await delete(audioTracks).go();
        await into(preferences).insert(
          PreferenceRow(
            key: QueuePreference.key,
            value: PreferenceValue(queuePreference: queue.preference),
          ),
          mode: InsertMode.insertOrReplace,
        );
      });
      return;
    }

    await transaction(() async {
      /// Insert Podcasts from audio tracks
      await batch((b) {
        b.insertAll(
          podcasts,
          queue.audioTracks.map((e) => podcastRowFromModel(e.podcast)).toList(),
          mode: InsertMode.insertOrIgnore,
        );
      });

      /// Insert Episodes from audio tracks
      await batch((b) {
        b.insertAll(
          episodes,
          queue.audioTracks.map((e) => episodeRowFromModel(e.episode)).toList(),
          mode: InsertMode.insertOrIgnore,
        );
      });

      /// Insert audiotracks
      await batch((b) {
        b.insertAll(
          audioTracks,
          queue.audioTracks.map((e) => audioTrackRowFromModel(e)).toList(),
          mode: InsertMode.insertOrReplace,
        );
      });

      /// Delete any additional audio tracks
      await (delete(audioTracks)
            ..where(
              (tbl) => tbl.position.isBiggerOrEqualValue(
                queue.audioTracks.length,
              ),
            ))
          .go();

      /// Update preference
      await into(preferences).insert(
        PreferenceRow(
          key: QueuePreference.key,
          value: PreferenceValue(queuePreference: queue.preference),
        ),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Stream<Queue> watchQueue() {
    return Rx.combineLatest2<QueuePreference, List<AudioTrack>, Queue>(
      (select(preferences)..where((tbl) => tbl.key.equals(QueuePreference.key)))
          .watchSingle()
          .map((x) => x.value.queuePreference),
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
      (prefs, tracks) => Queue(
        audioTracks: tracks ?? [],
        position: prefs.position,
        enabled: prefs.enabled,
      ),
    );
  }

  Future<Queue> getQueue() {
    return watchQueue().first;
  }

  Future<AudioTrack> getNowPlaying() async {
    final prefsRow = await (select(preferences)
          ..where((tbl) => tbl.key.equals(QueuePreference.key)))
        .getSingle();
    if (prefsRow == null || prefsRow.value.queuePreference.position == -1) {
      return null;
    }

    final audioTrackRow = await (select(audioTracks)
          ..where((tbl) => tbl.position.equals(
                prefsRow.value.queuePreference.position,
              )))
        .getSingle();
    if (audioTrackRow == null) {
      return null;
    }

    final row = await (select(episodes)
          ..where((tbl) => tbl.id.equals(audioTrackRow.episodeId)))
        .join([
      innerJoin(podcasts, podcasts.id.equalsExp(episodes.podcastId)),
    ]).getSingle();

    final episode = row.readTable(episodes);
    final podcast = row.readTable(podcasts);
    return AudioTrack(
      episode: episode.toModel(),
      podcast: podcast.toModel(),
      position: prefsRow.value.queuePreference.position,
    );
  }
}
