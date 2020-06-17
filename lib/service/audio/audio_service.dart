import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';
import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:phenopod/model/main.dart';
import 'package:phenopod/background/audio_player/background_player_task.dart';
import 'package:phenopod/utils/request.dart';

part 'audio_service_impl.dart';

enum AudioState {
  none,
  buffering,
  connecting,
  playing,
  paused,
  stopped,
}

class PositionState {
  final Duration position;
  final Duration duration;

  PositionState({@required this.position, @required this.duration});

  factory PositionState.none() {
    return PositionState(position: Duration.zero, duration: Duration.zero);
  }
}

abstract class IAudioService {
  // Stream of audio state transitions
  Stream<AudioState> get audioState;

  // Stream of changes to position
  Stream<PositionState> get positionState;

  // Play given episode
  Future<void> playEpisode(AudioTrack audioTrack);

  // Resume current episode
  Future<void> play();

  // Pause the current episode
  Future<void> pause();

  // Rewind the current episode by preset number of seconds
  Future<void> rewind();

  // Fast forward the current episode by preset number of seconds
  Future<void> fastForward();

  // Seek to specified position within current episodes duration
  Future<void> seek(Duration position);

  Future<void> dispose();
}
