part of '../sqldb.dart';

@UseDao(tables: [Podcasts, Episodes, Subscriptions])
class PodcastDao extends DatabaseAccessor<SqlDb> with _$PodcastDaoMixin {
  PodcastDao(SqlDb db) : super(db);

  Future<void> savePodcasts(
    List<Podcast> podcasts_, {
    bool replace = true,
  }) async {
    if (podcasts_.isNotEmpty) {
      await batch((b) => b.insertAll(
            podcasts,
            podcasts_.map((p) => podcastRowFromModel(p)).toList(),
            mode: replace
                ? InsertMode.insertOrReplace
                : InsertMode.insertOrIgnore,
          ));
    }
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

  Stream<Podcast> watchPodcast(String id) {
    return (select(podcasts)..where((tbl) => tbl.id.equals(id)))
        .watchSingle()
        .map((row) => row?.toModel());
  }

  Stream<List<Podcast>> watchSubscribedPodcasts() {
    return select(podcasts)
        .join([
          innerJoin(
            subscriptions,
            subscriptions.podcastId.equalsExp(podcasts.id),
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
