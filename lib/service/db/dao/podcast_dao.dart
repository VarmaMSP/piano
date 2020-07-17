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
              cacheUpdatedAt: Value(DateTime.now()),
            ),
      ),
    );
  }

  Future<void> updateCacheDetails(
    String podcastId, {
    bool cachedAllEpisodes,
  }) async {
    await (update(podcasts)..where((tbl) => tbl.id.equals(podcastId))).write(
      PodcastsCompanion(
        cachedAllEpisodes: cachedAllEpisodes != null && cachedAllEpisodes
            ? Value(true)
            : Value.absent(),
        cacheUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<Podcast> getPodcast({String id, String urlParam}) async {
    assert((id != null) != (urlParam != null));
    final row = id != null
        ? await (select(podcasts)..where((tbl) => tbl.id.equals(id)))
            .getSingle()
        : await (select(podcasts)
              ..where((tbl) => tbl.urlParam.equals(urlParam)))
            .getSingle();
    return row?.toModel();
  }

  Stream<Podcast> watchPodcast({String id, String urlParam}) {
    assert((id != null) != (urlParam != null));
    return (select(podcasts)
          ..where(
            (tbl) =>
                id != null ? tbl.id.equals(id) : tbl.urlParam.equals(urlParam),
          ))
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
