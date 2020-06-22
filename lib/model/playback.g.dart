// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'playback.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PlaybackCopyWithExtension on Playback {
  Playback copyWith({
    int duration,
    String episodeId,
    String lastPlayedAt,
    double progress,
  }) {
    return Playback(
      duration: duration ?? this.duration,
      episodeId: episodeId ?? this.episodeId,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
      progress: progress ?? this.progress,
    );
  }
}