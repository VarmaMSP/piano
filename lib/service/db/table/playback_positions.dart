part of '../db.dart';

/// * This table stores playback progress of each episode
/// * that user played
@DataClassName('PlaybackPositionRow')
class PlaybackPositions extends Table {
  TextColumn get episodeId =>
      text().customConstraint('REFERENCES episodes(id)')();
  IntColumn get position => integer()();
  IntColumn get duration => integer()();

  @override
  Set<Column> get primaryKey => {episodeId};
}

PlaybackPositionRow playbackPositionRowFromModel(PlaybackPosition model) {
  return PlaybackPositionRow(
    episodeId: model.episodeId,
    position: model.position.inSeconds,
    duration: model.duration.inSeconds,
  );
}

extension PlaybackPositionRowExtension on PlaybackPositionRow {
  PlaybackPosition toModel() {
    return PlaybackPosition(
      episodeId: episodeId,
      position: Duration(seconds: position),
      duration: Duration(seconds: duration),
      percentage: duration > 0 ? position / duration : 0.0,
    );
  }
}