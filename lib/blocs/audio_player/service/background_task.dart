import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

/// * Controls
const playControl = MediaControl(
  androidIcon: 'drawable/ic_play_circle_outline',
  label: 'Play',
  action: MediaAction.play,
);

const pauseControl = MediaControl(
  androidIcon: 'drawable/ic_pause_circle_outline',
  label: 'Pause',
  action: MediaAction.pause,
);

const rewindControl = MediaControl(
  androidIcon: 'drawable/ic_fast_rewind',
  label: 'Previous',
  action: MediaAction.rewind,
);

const fastForwardControl = MediaControl(
  androidIcon: 'drawable/ic_fast_forward',
  label: 'Next',
  action: MediaAction.fastForward,
);

const stopControl = MediaControl(
  androidIcon: 'drawable/ic_stop',
  label: 'Stop',
  action: MediaAction.stop,
);

/// * EntryPoint
void backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

/// * States set by AudioTask
/// * -----------------------
/// * [BasicPlaybackState.none] -> audioplayer has closed
///
/// * States set by AudioPlayer
/// * -------------------------
/// * [BasicPlaybackState.connecting] -> connecting
/// * [BasicPlaybackState.buffering] -> audio is buffering
/// * [BasicPlaybackState.paused] -> audio is paused
/// * [BasicPlaybackState.playing] -> audio is playing
/// * [BasicPlaybackState.stopped] -> audio playback is complete
///
class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _playing = false;
  StreamSubscription<AudioPlaybackEvent> _eventSubscription;

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    _eventSubscription = _audioPlayer.playbackEventStream.listen(
      (AudioPlaybackEvent event) {
        final bufferingState =
            event.buffering ? AudioProcessingState.buffering : null;
        switch (event.state) {
          case AudioPlaybackState.paused:
            _setState(
              bufferingState ?? AudioProcessingState.ready,
              position: event.position,
            );
            break;
          case AudioPlaybackState.playing:
            _setState(
              bufferingState ?? AudioProcessingState.ready,
              position: event.position,
            );
            break;
          case AudioPlaybackState.connecting:
            _setState(
              AudioProcessingState.connecting,
              position: event.position,
            );
            break;
          default:
            break;
        }
      },
    );
  }

  @override
  Future<void> onPlayMediaItem(MediaItem mediaItem) async {
    if (_canStopCurrentPlayback()) {
      await _audioPlayer.stop();
    }

    try {
      // Show Item without duration
      await AudioServiceBackground.setMediaItem(mediaItem);
      // AudioPlayerState: connecting -> stopped
      final duration = await _audioPlayer.setUrl(mediaItem.id);
      // Show Item in notification tray with duration
      await AudioServiceBackground.setMediaItem(
        mediaItem.copyWith(duration: duration),
      );
      // Play Audio
      onPlay();
    } catch (err) {
      // _setState(BasicPlaybackState.error, position: Duration.zero);
    }
  }

  @override
  void onPlay() {
    if (_canPlayCurrentPlayback()) {
      _playing = true;
      _audioPlayer.play();
    }
  }

  @override
  void onPause() {
    if (_canPauseCurrentPlayback()) {
      _playing = false;
      _audioPlayer.pause();
    }
  }

  @override
  void onSeekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  // @override
  // void onClick(MediaButton button) {
  //   AudioServiceBackground.state.basicState == BasicPlaybackState.playing
  //       ? onPause()
  //       : onPlay();
  // }

  @override
  Future<void> onStop() async {
    // stopped and none events from audioplayer will be skipped
    if (_canStopCurrentPlayback()) {
      await _audioPlayer.stop();
    }
    await _audioPlayer.dispose();
    await _eventSubscription.cancel();
    await super.onStop();
  }

  void _setState(
    AudioProcessingState processingState, {
    Duration duration,
    Duration position,
  }) {
    AudioServiceBackground.setState(
      controls: <MediaControl>[
        rewindControl,
        pauseControl,
        fastForwardControl,
        stopControl,
      ],
      systemActions: <MediaAction>[MediaAction.seekTo],
      processingState:
          processingState ?? AudioServiceBackground.state.processingState,
      playing: _playing,
      position: duration ?? position ?? Duration.zero,
    );
  }

  bool _canPauseCurrentPlayback() {
    final audioPlaybackState = _audioPlayer.playbackState;
    return audioPlaybackState == AudioPlaybackState.playing;
  }

  bool _canPlayCurrentPlayback() {
    final audioPlaybackState = _audioPlayer.playbackState;
    return audioPlaybackState != AudioPlaybackState.connecting &&
        audioPlaybackState != AudioPlaybackState.none;
  }

  bool _canStopCurrentPlayback() {
    final audioPlaybackState = _audioPlayer.playbackState;
    return audioPlaybackState == AudioPlaybackState.paused ||
        audioPlaybackState == AudioPlaybackState.playing ||
        audioPlaybackState == AudioPlaybackState.completed;
  }
}
