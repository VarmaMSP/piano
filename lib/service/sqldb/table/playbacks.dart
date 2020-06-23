part of '../sqldb.dart';

/// * This table stores playback progress of each episode
/// * that user played
@DataClassName('PlaybackRow')
class Playbacks extends Table {
  TextColumn get episodeId =>
      text().customConstraint('REFERENCES episodes(id)')();
  IntColumn get position => integer()();
  IntColumn get duration => integer()();
  TextColumn get lastPlayedAt => text()();

  @override
  Set<Column> get primaryKey => {episodeId};
}

PlaybackRow playbackRowFromModel(Playback model) {
  return PlaybackRow(
    episodeId: model.episodeId,
    position: model?.position?.inSeconds ?? 0,
    duration: model?.duration?.inSeconds ?? 0,
    lastPlayedAt: model?.lastPlayedAt ?? 0,
  );
}

extension PlaybackRowExtension on PlaybackRow {
  Playback toModel() {
    return Playback(
      episodeId: episodeId,
      position: Duration(seconds: position),
      duration: Duration(seconds: duration),
      lastPlayedAt: lastPlayedAt,
    );
  }
}
