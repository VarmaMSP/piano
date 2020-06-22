part of '../sqldb.dart';

/// * This table stores playback progress of each episode
/// * that user played
@DataClassName('PlaybackRow')
class Playbacks extends Table {
  TextColumn get episodeId =>
      text().customConstraint('REFERENCES episodes(id)')();
  RealColumn get progress => real()();
  IntColumn get duration => integer()();
  TextColumn get lastPlayedAt => text()();

  @override
  Set<Column> get primaryKey => {episodeId};
}

PlaybackRow playbackRowFromModel(Playback model) {
  return PlaybackRow(
    episodeId: model.episodeId,
    progress: model.progress,
    duration: model.duration,
    lastPlayedAt: model.lastPlayedAt,
  );
}

extension PlaybackRowExtension on PlaybackRow {
  Playback toModel() {
    return Playback(
      episodeId: episodeId,
      progress: progress,
      duration: duration,
      lastPlayedAt: lastPlayedAt,
    );
  }
}
