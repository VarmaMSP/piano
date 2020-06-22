import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'playback.g.dart';

@CopyWith()
class Playback extends Equatable {
  final String episodeId;
  final double progress;
  final int duration;
  final String lastPlayedAt;

  Playback({
    @required this.episodeId,
    @required this.progress,
    @required this.duration,
    this.lastPlayedAt,
  });

  factory Playback.empty(String episodeId) {
    return Playback(
      episodeId: episodeId,
      progress: 0.0,
      duration: 0,
    );
  }

  @override
  List<Object> get props => [episodeId];
}
