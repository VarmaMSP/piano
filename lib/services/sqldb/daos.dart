part of 'sqldb.dart';

@UseDao(tables: [Podcasts, Episodes])
class PodcastDao extends DatabaseAccessor<SqlDb> with _$PodcastDaoMixin {
  PodcastDao(SqlDb db) : super(db);

  Future<void> insertScreenData(PodcastScreenData pageData) async {
    await into(podcasts)
        .insertOnConflictUpdate(podcastRowFromModel(pageData.podcast));

    await batch((b) {
      b.insertAllOnConflictUpdate(
        episodes,
        pageData.episodes.map((e) => episodeRowFromModel(e)).toList(),
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
            (tbl) =>
                OrderingTerm(expression: tbl.pubDate, mode: OrderingMode.desc)
          ]))
        .get();

    return PodcastScreenData(
      podcast: podcastRow.toModel(),
      episodes: episodeRows.map((e) => e.toModel()).toList(),
      receivedAllEpisodes: episodeRows.length < 15,
    );
  }
}
