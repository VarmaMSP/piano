part of '../sqldb.dart';

@UseDao(tables: [PlaybackPositions])
class PlaybackPositionDao extends DatabaseAccessor<SqlDb>
    with _$PlaybackPositionDaoMixin {
  PlaybackPositionDao(SqlDb db) : super(db);

  Future<void> savePlayback(PlaybackPosition playback) async {
    await into(playbackPositions).insert(
      playbackRowFromModel(playback),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> updateProgress(PlaybackPosition playback) async {
    await (update(playbackPositions)
          ..where((tbl) => tbl.episodeId.equals(playback.episodeId)))
        .write(
      PlaybackPositionsCompanion(position: Value(playback.position.inSeconds)),
    );
  }

  Stream<PlaybackPosition> watchPlayback(String episodeId) {
    return (select(playbackPositions)
          ..where((tbl) => tbl.episodeId.equals(episodeId)))
        .watchSingle()
        .map((row) =>
            row != null ? row.toModel() : PlaybackPosition.empty(episodeId));
  }

  Future<PlaybackPosition> getPlayback(String episodeId) {
    return watchPlayback(episodeId).first;
  }
}
