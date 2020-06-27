part of '../sqldb.dart';

@UseDao(tables: [Episodes])
class EpisodeDao extends DatabaseAccessor<SqlDb> with _$EpisodeDaoMixin {
  EpisodeDao(SqlDb db) : super(db);

  Future<void> saveEpisodes(List<Episode> episodes_) {
    return batch(
      (b) => b.insertAll(
        episodes,
        episodes_.map((e) => episodeRowFromModel(e)).toList(),
        mode: InsertMode.insertOrReplace,
      ),
    );
  }
}
