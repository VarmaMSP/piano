part of '../sqldb.dart';

/// * This table stores state of audio player at any given time
@DataClassName('AudioPlayerSnapshotRow')
class AudioPlayerSnapshots extends Table {
  /// Id value should always be equal to 0, this ensures
  /// that only one row exists at any given time
  IntColumn get id => integer()();
  IntColumn get queuePosition => integer()();
  BoolColumn get queueEnabled => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

AudioPlayerSnapshotRow audioPlayerSnapshotRowFromModel(
  AudioPlayerSnapshot model,
) {
  return AudioPlayerSnapshotRow(
    id: 0,
    queuePosition: model.queue.position,
    queueEnabled: model.queue.enabled,
  );
}
