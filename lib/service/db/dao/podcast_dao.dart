part of '../db.dart';

@UseDao(tables: [Podcasts, Episodes, Subscriptions])
class PodcastDao extends DatabaseAccessor<SqlDb> with _$PodcastDaoMixin {
  PodcastDao(SqlDb db) : super(db);

  Future<void> savePodcasts(List<Podcast> podcastList) async {
    if (podcastList.isNotEmpty) {
      await batch(
        (b) => b.insertAll(
          podcasts,
          podcastList.map((p) => podcastRowFromModel(p)).toList(),
          mode: InsertMode.insertOrIgnore,
        ),
      );
    }
  }

  Future<void> upsert(Podcast podcast) async {
    final row = podcastRowFromModel(podcast);
    await into(podcasts).insert(
      row,
      onConflict: DoUpdate(
        (old) => row.toCompanion(true).copyWith(
              cachedAllEpisodes:
                  podcast.cachedAllEpisodes != null && podcast.cachedAllEpisodes
                      ? Value(true)
                      : Value.absent(),
              cacheUpdatedAt:
                  podcast.cachedAllEpisodes != null && podcast.cachedAllEpisodes
                      ? Value(DateTime.now())
                      : Value.absent(),
            ),
      ),
    );
  }

  Future<void> updateCacheDetails(
    String podcastId, {
    bool cachedAllEpisodes,
  }) async {
    if (!cachedAllEpisodes) {
      return;
    }

    await (update(podcasts)..where((tbl) => tbl.id.equals(podcastId))).write(
      PodcastsCompanion(
        cachedAllEpisodes: cachedAllEpisodes != null && cachedAllEpisodes
            ? Value(true)
            : Value.absent(),
        cacheUpdatedAt: cachedAllEpisodes != null && cachedAllEpisodes
            ? Value(DateTime.now())
            : Value.absent(),
      ),
    );
  }

  Stream<Podcast> watchPodcast(String podcastId) {
    return (select(podcasts)..where((tbl) => tbl.id.equals(podcastId)))
        .watchSingle()
        .map((row) => row?.toModel());
  }

  Stream<List<Podcast>> watchSubscribedPodcasts() {
    return (select(subscriptions)
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.updatedAt,
                  mode: OrderingMode.desc,
                )
          ]))
        .join([
          innerJoin(
            podcasts,
            podcasts.id.equalsExp(subscriptions.podcastId),
          )
        ])
        .watch()
        .map(
          (rows) => rows.map((row) {
            final podcast = row.readTable(podcasts);
            return podcast.toModel();
          }).toList(),
        );
  }

  Future<void> deletePodcasts(List<String> podcastIds) async {
    final toDelete = await _filterPodcastsWithReferences(podcastIds);
    await (delete(podcasts)..where((tbl) => tbl.id.isIn(toDelete))).go();
  }

  Future<List<String>> _filterPodcastsWithReferences(
    List<String> podcastIds,
  ) async {
    final idSet = {for (var id in podcastIds) id};

    // References in episodes
    if (idSet.isNotEmpty) {
      final fromEpisodes = (await (select(episodes)
                ..where((tbl) => tbl.podcastId.isIn(idSet.toList())))
              .get())
          .map((i) => i.podcastId);
      idSet.removeAll(fromEpisodes);
    }

    // References in subscriptions
    if (idSet.isNotEmpty) {
      final fromSubscriptions = (await (select(subscriptions)
                ..where((tbl) => tbl.podcastId.isIn(idSet.toList())))
              .get())
          .map((i) => i.podcastId);
      idSet.removeAll(fromSubscriptions);
    }

    return idSet.toList();
  }
}
