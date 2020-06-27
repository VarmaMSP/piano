part of '../sqldb.dart';

@UseDao(tables: [Podcasts, Episodes])
class PodcastDao extends DatabaseAccessor<SqlDb> with _$PodcastDaoMixin {
  PodcastDao(SqlDb db) : super(db);

  Future<void> savePodcast(Podcast podcast) async {
    await into(podcasts).insert(
      podcastRowFromModel(podcast),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> savePodcasts(List<Podcast> podcasts_) async {
    if (podcasts_.isEmpty) {
      await batch((b) => b.insertAll(
            podcasts,
            podcasts_.map((p) => podcastRowFromModel(p)).toList(),
            mode: InsertMode.insertOrReplace,
          ));
    }
  }

  Future<Podcast> getPodcast(String podcastId) async {
    final row = await (select(podcasts)
          ..where((tbl) => tbl.id.equals(podcastId)))
        .getSingle();
    return row.toModel();
  }

  Future<void> saveScreenData(PodcastScreenData pageData) async {
    await transaction(() async {
      await into(podcasts).insert(
        podcastRowFromModel(pageData.podcast),
        mode: InsertMode.insertOrReplace,
      );

      await batch((b) {
        b.insertAll(
          episodes,
          pageData.episodes.map((e) => episodeRowFromModel(e)).toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<void> saveEpisodes(List<Episode> episodes_) async {
    await batch((b) {
      b.insertAll(
        episodes,
        episodes_.map((e) => episodeRowFromModel(e)).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<PodcastScreenData> getScreenData(String podcastUrlParam) async {
    final podcastRow = await (select(podcasts)
          ..where((tbl) => tbl.urlParam.equals(podcastUrlParam)))
        .getSingle();

    if (podcastRow == null) {
      return null;
    }

    final episodeRows = await (select(episodes)
          ..where((tbl) => tbl.podcastId.equals(podcastRow.id))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.pubDate,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();

    return PodcastScreenData(
      podcast: podcastRow.toModel(),
      episodes: episodeRows.map((e) => e.toModel()).toList(),
      receivedAllEpisodes: episodeRows.length < 15,
    );
  }
}
