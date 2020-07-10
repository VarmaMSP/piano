part of '../db.dart';

@UseDao(tables: [PlaybackPositions])
class PlaybackPositionDao extends DatabaseAccessor<SqlDb>
    with _$PlaybackPositionDaoMixin {
  PlaybackPositionDao(SqlDb db) : super(db);

  Future<void> upsert(PlaybackPosition m) async {
    await into(playbackPositions).insert(
      playbackPositionRowFromModel(m),
      onConflict: DoUpdate(
        (_) => PlaybackPositionsCompanion(
          position: Value(m.position.inSeconds),
          updatedAt: Value(DateTime.now()),
        ),
      ),
    );
  }

  Stream<PlaybackPosition> watchByEpisode(String episodeId) {
    return (select(playbackPositions)
          ..where((tbl) => tbl.episodeId.equals(episodeId)))
        .watchSingle()
        .map((row) => row?.toModel());
  }
}
