part of '../sqldb.dart';

@UseDao(tables: [PlaybackPositions])
class PlaybackPositionDao extends DatabaseAccessor<SqlDb>
    with _$PlaybackPositionDaoMixin {
  PlaybackPositionDao(SqlDb db) : super(db);

  Future<void> savePlaybackPosition(PlaybackPosition playback) async {
    await into(playbackPositions).insert(
      playbackRowFromModel(playback),
      mode: InsertMode.insertOrReplace,
    );
  }

  Stream<PlaybackPosition> watchPlaybackPosition(String episodeId) {
    return (select(playbackPositions)
          ..where((tbl) => tbl.episodeId.equals(episodeId)))
        .watchSingle()
        .map((row) =>
            row != null ? row.toModel() : PlaybackPosition.empty(episodeId));
  }

  Future<void> setPosition(PlaybackPosition playback) async {
    await (update(playbackPositions)
          ..where((tbl) => tbl.episodeId.equals(playback.episodeId)))
        .write(
      PlaybackPositionsCompanion(position: Value(playback.position.inSeconds)),
    );
  }
}
