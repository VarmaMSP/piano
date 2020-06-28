import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'playback_position.g.dart';

@CopyWith()
class PlaybackPosition extends Equatable {
  final String episodeId;
  final Duration position;
  final Duration duration;
  final double percentage;

  PlaybackPosition({
    this.episodeId,
    this.position,
    this.duration,
    this.percentage,
  });

  factory PlaybackPosition.empty(String episodeId) {
    return PlaybackPosition(
      episodeId: episodeId,
      position: Duration.zero,
      duration: Duration.zero,
      percentage: 0.0,
    );
  }

  bool get isEmpty => duration.inSeconds == 0;

  @override
  List<Object> get props => [episodeId];
}
