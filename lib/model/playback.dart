import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'playback.g.dart';

@CopyWith()
class Playback extends Equatable {
  final String episodeId;
  final Duration position;
  final Duration duration;
  final String lastPlayedAt;

  Playback({
    @required this.episodeId,
    this.position,
    this.duration,
    this.lastPlayedAt,
  });

  factory Playback.empty(String episodeId) {
    return Playback(
      episodeId: episodeId,
      position: Duration.zero,
      duration: Duration.zero,
    );
  }

  bool get isEmpty => duration.inSeconds == 0;

  @override
  List<Object> get props => [episodeId];
}
