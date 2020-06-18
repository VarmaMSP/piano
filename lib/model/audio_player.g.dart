// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AudioPlayerSnapshotCopyWithExtension on AudioPlayerSnapshot {
  AudioPlayerSnapshot copyWith({
    Queue queue,
  }) {
    return AudioPlayerSnapshot(
      queue: queue ?? this.queue,
    );
  }
}

extension QueueCopyWithExtension on Queue {
  Queue copyWith({
    List<AudioTrack> audioTracks,
    bool enabled,
    int position,
  }) {
    return Queue(
      audioTracks: audioTracks ?? this.audioTracks,
      enabled: enabled ?? this.enabled,
      position: position ?? this.position,
    );
  }
}

extension AudioTrackCopyWithExtension on AudioTrack {
  AudioTrack copyWith({
    Episode episode,
    Podcast podcast,
    int position,
  }) {
    return AudioTrack(
      episode: episode ?? this.episode,
      podcast: podcast ?? this.podcast,
      position: position ?? this.position,
    );
  }
}
