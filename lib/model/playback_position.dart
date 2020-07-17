// Package imports:
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'playback_position.g.dart';

@CopyWith()
class PlaybackPosition extends Equatable {
  final String episodeId;
  final Duration position;
  final Duration duration;
  final DateTime updatedAt;

  final double percentage;

  PlaybackPosition({
    this.episodeId,
    this.position,
    this.duration,
    this.updatedAt,
    this.percentage,
  });

  @override
  List<Object> get props => [episodeId];
}
