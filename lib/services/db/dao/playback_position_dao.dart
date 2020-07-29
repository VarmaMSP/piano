part of '../db.dart';

@UseDao(tables: [PlaybackPositions])
class PlaybackPositionDao extends DatabaseAccessor<SqlDb>
    with _$PlaybackPositionDaoMixin {
  PlaybackPositionDao(SqlDb db) : super(db);

  Future<void> upsert(PlaybackPosition pos) async {
    await into(playbackPositions).insert(
      playbackPositionRowFromModel(pos),
      onConflict: DoUpdate(
        (_) => PlaybackPositionsCompanion(
          position: Value(pos.position.inSeconds),
          duration: pos.duration != null
              ? Value(pos.duration.inSeconds)
              : Value.absent(),
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
