part of '../sqldb.dart';

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
        ),
      ),
    );
  }

  Stream<PlaybackPosition> watchByEpisode(String episodeId) {
    return (select(playbackPositions)
          ..where((tbl) => tbl.episodeId.equals(episodeId)))
        .watchSingle()
        .map((row) =>
            row != null ? row.toModel() : PlaybackPosition.empty(episodeId));
  }

  Stream<PlaybackPosition> watchPlaybackPosition(String episodeId) {
    return (select(playbackPositions)
          ..where((tbl) => tbl.episodeId.equals(episodeId)))
        .watchSingle()
        .map((row) =>
            row != null ? row.toModel() : PlaybackPosition.empty(episodeId));
  }

  Future<void> savePlaybackPosition(PlaybackPosition playback) async {
    await into(playbackPositions).insert(
      playbackPositionRowFromModel(playback),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> setPosition(PlaybackPosition playback) async {
    await (update(playbackPositions)
          ..where((tbl) => tbl.episodeId.equals(playback.episodeId)))
        .write(
      PlaybackPositionsCompanion(position: Value(playback.position.inSeconds)),
    );
  }
}
