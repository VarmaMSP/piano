import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:phenopod/background/audio_player/background_player_task.dart';

part 'audio_service_impl.dart';

AudioService newAudioService() {
  return _audioServiceImpl();
}

enum AudioState {
  none,
  buffering,
  connecting,
  playing,
  paused,
  stopped,
}

class PositionState extends Equatable {
  final Duration position;
  final Duration duration;

  PositionState({@required this.position, @required this.duration});

  @override
  List<Object> get props => [position, duration];

  @override
  String toString() =>
      '{ position: ${position.inSeconds}, duration: ${duration.inSeconds} }';
}

abstract class AudioService {
  // Stream of audio state transitions
  Stream<AudioState> get audioState;

  // Stream of changes to position
  Stream<PositionState> get positionState;

  // Connect to background audio service isolate
  Future<void> connect();

  // Disconnect from background audio service isolate
  Future<void> disconnect();

  /// Makes background service load latest audioPlayerSnapshot
  /// This method should be called anytime the UI makes changes
  /// to the audioPlayerSnapshot
  ///
  /// This is a expensive method to call, use syncNowPlaying
  /// when appropriate
  Future<void> syncSnapshot();

  /// Makes background service load now playing track
  Future<void> syncNowPlaying();

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
