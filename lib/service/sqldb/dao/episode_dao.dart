part of '../sqldb.dart';

@UseDao(tables: [Episodes])
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

  Future<List<Episode>> getEpisodesByPodcast(String podcastId) async {
    final rows = await (select(episodes)
          ..where((tbl) => tbl.podcastId.equals(podcastId))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.pubDate,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();
    return rows.map((e) => e.toModel()).toList();
  }

  Future<void> deleteEpisodesByPodcast(String podcastId) {
    return (delete(episodes)..where((tbl) => tbl.podcastId.equals(podcastId)))
        .go();
  }
}
