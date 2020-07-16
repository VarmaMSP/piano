// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'queue.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension QueueCopyWithExtension on Queue {
  Queue copyWith({
    List<AudioTrack> audioTracks,
    int position,
  }) {
    return Queue(
      audioTracks: audioTracks ?? this.audioTracks,
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
