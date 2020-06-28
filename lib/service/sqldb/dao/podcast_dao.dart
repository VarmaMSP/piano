part of '../sqldb.dart';

@UseDao(tables: [Podcasts, Subscriptions])
class PodcastDao extends DatabaseAccessor<SqlDb> with _$PodcastDaoMixin {
  PodcastDao(SqlDb db) : super(db);

  Future<void> savePodcast(Podcast podcast, {bool replace = true}) async {
    await into(podcasts).insert(
      podcastRowFromModel(podcast),
      mode: replace ? InsertMode.insertOrReplace : InsertMode.insertOrIgnore,
    );
  }

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

  Future<Podcast> getPodcast(String podcastId) async {
    final row = await (select(podcasts)
          ..where((tbl) => tbl.id.equals(podcastId)))
        .getSingle();
    return row?.toModel();
  }

  Future<Podcast> getPodcastByUrlParam(String podcastUrlParam) async {
    final row = await (select(podcasts)
          ..where((tbl) => tbl.urlParam.equals(podcastUrlParam)))
        .getSingle();
    return row?.toModel();
  }

  Future<void> deletePodcast(String podcastId) {
    return (delete(podcasts)..where((tbl) => tbl.id.equals(podcastId))).go();
  }
}
