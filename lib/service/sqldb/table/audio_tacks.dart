part of '../sqldb.dart';

/// * This table stores tracks that are in queue.
/// * - Tracks start from position 0.
/// * - Position of currently playing track is stored in [PlayerSnapshot.queuePosition]
@DataClassName('AudioTrackRow')
class AudioTracks extends Table {
  IntColumn get position => integer()();
  TextColumn get episodeId =>
      text().customConstraint('REFERENCES episodes(id)')();

  @override
  Set<Column> get primaryKey => {position};
}

AudioTrackRow audioTrackRowFromModel(AudioTrack model) {
  return AudioTrackRow(
    position: model.position,
    episodeId: model.episode.id,
  );
}
