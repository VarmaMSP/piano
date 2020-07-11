import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:phenopod/model/main.dart';
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
  Future<void> syncQueue({bool startTask = true});

  /// Makes background service load now playing track
  /// [startTask] Starts background task if background task is not running
  /// defaults to false
  Future<void> syncNowPlaying({bool startTask = true});

  /// Makes background service load setting
  Future<void> syncSetting();

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

  Future<void> dispose();
}
