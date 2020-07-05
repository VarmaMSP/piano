part of 'db.dart';

@UseDao(tables: [Episodes, AudioTracks, PlaybackPositions])
class EpisodeDao extends DatabaseAccessor<SqlDb> with _$EpisodeDaoMixin {
  EpisodeDao(SqlDb db) : super(db);

  Future<void> saveEpisodes(
    List<Episode> episodes_, {
    bool replace = true,
  }) async {
    if (episodes_.isNotEmpty) {
      return batch((b) => b.insertAll(
            episodes,
            episodes_.map((e) => episodeRowFromModel(e)).toList(),
            mode: replace
                ? InsertMode.insertOrReplace
                : InsertMode.insertOrIgnore,
          ));
    }
  }

  Stream<List<Episode>> watchEpisodesFromPodcast(String podcastId) {
    return (select(episodes)
          ..where((tbl) => tbl.podcastId.equals(podcastId))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.pubDate,
                  mode: OrderingMode.desc,
                )
          ]))
        .watch()
        .map((xs) => xs.map((x) => x.toModel()).toList());
  }

  Stream<List<Episode>> watchEpisodesByPodcastsPaginated({
    List<String> podcastIds,
    int offset = 0,
    int limit,
  }) {
    return (select(episodes)
          ..where((tbl) => tbl.podcastId.isIn(podcastIds))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.pubDate,
                  mode: OrderingMode.desc,
                )
          ])
          ..limit(limit, offset: offset))
        .watch()
        .map((xs) => xs.map((x) => x.toModel()).toList());
  }

  Stream<List<Episode>> watchEpisodesFromPodcasts(List<String> podcastIds) {
    return (select(episodes)
          ..where((tbl) => tbl.podcastId.isIn(podcastIds))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.pubDate,
                  mode: OrderingMode.desc,
                )
          ]))
        .watch()
        .map((xs) => xs.map((x) => x.toModel()).toList());
  }

  Future<void> deleteEpisodes(List<String> episodeIds) async {
    final toDelete = await _filterEpisodesWithReferences(episodeIds);
    if (toDelete.isNotEmpty) {
      await (delete(episodes)..where((tbl) => tbl.id.isIn(toDelete))).go();
    }
  }

  Future<void> deleteEpisodesFromPodcast(String podcastId) async {
    final episodeIds = (await (select(episodes)
              ..where((tbl) => tbl.podcastId.equals(podcastId)))
            .get())
        ?.map((i) => i.id);
    await deleteEpisodes(episodeIds ?? []);
  }

  /// Filters episodes ids that have any references to other tables
  Future<List<String>> _filterEpisodesWithReferences(
    List<String> episodeIds,
  ) async {
    final idSet = {for (var id in episodeIds) id};

    // References from audioTracks table
    if (idSet.isNotEmpty) {
      final fromAudioTracks = (await (select(audioTracks)
                ..where((tbl) => tbl.episodeId.isIn(idSet.toList())))
              .get())
          .map((i) => i.episodeId);
      idSet.removeAll(fromAudioTracks);
    }

    // References from playback positions table
    if (idSet.isNotEmpty) {
      final fromPlaybackPositions = (await (select(playbackPositions)
                ..where((tbl) => tbl.episodeId.isIn(idSet.toList())))
              .get())
          .map((i) => i.episodeId);
      idSet.removeAll(fromPlaybackPositions);
    }

    return idSet.toList();
  }
}
