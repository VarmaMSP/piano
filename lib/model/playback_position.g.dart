// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'playback_position.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PlaybackPositionCopyWithExtension on PlaybackPosition {
  PlaybackPosition copyWith({
    Duration duration,
    String episodeId,
    double percentage,
    Duration position,
  }) {
    return PlaybackPosition(
      duration: duration ?? this.duration,
      episodeId: episodeId ?? this.episodeId,
      percentage: percentage ?? this.percentage,
      position: position ?? this.position,
    );
  }
}
