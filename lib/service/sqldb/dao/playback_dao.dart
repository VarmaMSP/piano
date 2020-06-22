part of '../sqldb.dart';

@UseDao(tables: [Playbacks])
class PlaybackDao extends DatabaseAccessor<SqlDb> with _$PlaybackDaoMixin {
  PlaybackDao(SqlDb db) : super(db);

  Future<void> savePlayback(Playback playback) async {
    await into(playbacks).insert(
      playbackRowFromModel(playback),
      mode: InsertMode.insertOrReplace,
    );
  }

  Stream<Playback> watchPlayback(String episodeId) {
    return (select(playbacks)..where((tbl) => tbl.episodeId.equals(episodeId)))
        .watchSingle()
        .map((row) => row != null ? row.toModel() : Playback.empty(episodeId));
  }

  Future<Playback> getPlayback(String episodeId) {
    return watchPlayback(episodeId).first;
  }
}
