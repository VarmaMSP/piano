part of 'main.dart';

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
