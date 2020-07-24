// Dart imports:
import 'dart:async';

// Package imports:
import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:rxdart/subjects.dart';

// Project imports:
import 'package:phenopod/background/audio_player/background_player_task.dart';
import 'package:phenopod/model/main.dart';

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

abstract class AudioService {
  // Stream of audio state transitions
  Stream<AudioState> get audioState;

  // Stream of changes to position
  Stream<PlaybackPosition> get playbackPosition;

  // Connect to background audio service isolate
  Future<void> connect();

  // Disconnect from background audio service isolate
  Future<void> disconnect();

  // Stop background audio service
  Future<void> stop();

  /// Makes background service load latest queue from db. This
  /// method should be called anytime the UI makes changes
  /// to the queue
  ///
  /// This is a expensive method to call, use syncNowPlaying
  /// when appropriate
  Future<void> syncQueue({bool startTask = false});

  /// Makes background service load setting
  Future<void> syncSetting({bool startTask = false});

  // Resume current episode
  Future<void> play();

  // Pause the current episode
  Future<void> pause();

  // Seek to specified position within current episodes duration
  Future<void> seekTo(Duration position);

  // Fast forward the current episode by preset number of seconds
  Future<void> fastForward();

  // Rewind the current episode by preset number of seconds
  Future<void> rewind();

  // Dispose resources
  Future<void> dispose();
}
