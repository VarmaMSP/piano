part of '../sqldb.dart';

/// * This table stores playback progress of each episode
/// * that user played
@DataClassName('PlaybackPositionRow')
class PlaybackPositions extends Table {
  TextColumn get episodeId =>
      text().customConstraint('REFERENCES episodes(id)')();
  IntColumn get position => integer()();
  IntColumn get duration => integer()();
  RealColumn get percentage => real()();

  @override
  Set<Column> get primaryKey => {episodeId};
}

PlaybackPositionRow playbackRowFromModel(PlaybackPosition model) {
  return PlaybackPositionRow(
    episodeId: model.episodeId,
    position: model.position.inSeconds,
    duration: model.duration.inSeconds,
    percentage: model.percentage,
  );
}

extension PlaybackPositionRowExtension on PlaybackPositionRow {
  PlaybackPosition toModel() {
    return PlaybackPosition(
      episodeId: episodeId,
      position: Duration(seconds: position),
      duration: Duration(seconds: duration),
      percentage: percentage,
    );
  }
}
