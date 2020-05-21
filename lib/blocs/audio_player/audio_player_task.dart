import 'dart:async';
import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

/// * States set by AudioTask
/// * -----------------------
/// * [BasicPlaybackState.none] -> audioplayer has not loaded anything or closed
/// * [BasicPlaybackState.skippingToQueueItem] -> Using this to send duration to UI

/// * States set by AudioPlayer
/// * -----------------------
/// * [BasicPlaybackState.connecting] with duration -> duration is loaded
/// * [BasicPlaybackState.buffering] -> audio is buffering
/// * [BasicPlaybackState.paused] -> audio is paused
/// * [BasicPlaybackState.playing] -> audio is playing
/// * [BasicPlaybackState.stopped] -> audio playback is complete

class AudioPlayerEvent {
  const AudioPlayerEvent({
    this.buffering,
    this.position,
    this.audioPlaybackState,
  });

  final bool buffering;
  final Duration position;
  final AudioPlaybackState audioPlaybackState;

  bool get isValid =>
      buffering != null && position != null && audioPlaybackState != null;
}

class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Completer<void> _completer = Completer<void>();

  @override
  Future<void> onStart() async {
    final StreamSubscription<AudioPlaybackEvent> eventSubscription =
        _audioPlayer.playbackEventStream.listen((AudioPlaybackEvent event) {
      // We dont care if audioPlayer is stopped and none
      if (event.state != AudioPlaybackState.stopped &&
          event.state != AudioPlaybackState.none) {
        _setState(
          _toBasicPlaybackState(event.buffering, event.state),
          position: event.position,
        );
      }
    });

    await _completer.future;
    eventSubscription.cancel();
  }

  @override
  Future<void> onPlayMediaItem(MediaItem mediaItem) async {
    if (_canStopCurrentPlayback()) {
      await _audioPlayer.stop();
    }

    try {
      // Show Item without duration
      AudioServiceBackground.setMediaItem(mediaItem);
      // AudioPlayerState: connecting -> stopped
      final Duration duration =
          await _audioPlayer.setUrl(mediaItem.id).catchError((dynamic error) {
        log('AudioPlayerTaskError: ${error.toString()}');
      });
      // Show Item in notification tray with duration
      AudioServiceBackground.setMediaItem(
        mediaItem.copyWith(duration: duration?.inMilliseconds),
      );
      // Notify UI of duration and pause for onPlay to work
      _setState(
        BasicPlaybackState.skippingToQueueItem,
        duration: duration,
      );
      // Play Audio
      onPlay();
    } catch (err) {
      _setState(BasicPlaybackState.error, position: Duration.zero);
    }
  }

  @override
  void onPlay() {
    if (_canPlayCurrentPlayback()) {
      _audioPlayer.play();
    }
  }

  @override
  void onPause() {
    if (_canPauseCurrentPlayback()) {
      _audioPlayer.pause();
    }
  }

  @override
  void onClick(MediaButton button) {
    AudioServiceBackground.state.basicState == BasicPlaybackState.playing
        ? onPause()
        : onPlay();
  }

  @override
  Future<void> onStop() async {
    // stopped and none events from audioplayer will be skipped
    if (_canStopCurrentPlayback()) {
      await _audioPlayer.stop();
    }
    await _audioPlayer.dispose();
    // Notify UI to close
    _setState(BasicPlaybackState.none);
    // Close this isolate
    _completer.complete();
  }

  bool _canPauseCurrentPlayback() {
    final AudioPlaybackState audioPlaybackState = _audioPlayer.playbackState;
    return audioPlaybackState == AudioPlaybackState.playing;
  }

  bool _canPlayCurrentPlayback() {
    final AudioPlaybackState audioPlaybackState = _audioPlayer.playbackState;
    return audioPlaybackState != AudioPlaybackState.connecting &&
        audioPlaybackState != AudioPlaybackState.none;
  }

  bool _canStopCurrentPlayback() {
    final AudioPlaybackState audioPlaybackState = _audioPlayer.playbackState;
    return audioPlaybackState == AudioPlaybackState.paused ||
        audioPlaybackState == AudioPlaybackState.playing ||
        audioPlaybackState == AudioPlaybackState.completed;
  }

  BasicPlaybackState _toBasicPlaybackState(
    bool buffering,
    AudioPlaybackState audioPlaybackstate,
  ) {
    switch (audioPlaybackstate) {
      case AudioPlaybackState.paused:
        return BasicPlaybackState.paused;
      case AudioPlaybackState.playing:
        return BasicPlaybackState.playing;
      case AudioPlaybackState.connecting:
        return BasicPlaybackState.connecting;
      case AudioPlaybackState.completed:
        return BasicPlaybackState.stopped;
      default:
        if (buffering) {
          return BasicPlaybackState.buffering;
        } else {
          throw Exception('Invalid input for this method $audioPlaybackstate');
        }
    }
  }

  void _setState(
    BasicPlaybackState state, {
    Duration duration,
    Duration position,
  }) {
    const MediaControl playControl = MediaControl(
      androidIcon: 'drawable/ic_play_circle_outline',
      label: 'Play',
      action: MediaAction.play,
    );

    const MediaControl pauseControl = MediaControl(
      androidIcon: 'drawable/ic_pause_circle_outline',
      label: 'Pause',
      action: MediaAction.pause,
    );

    const MediaControl rewindControl = MediaControl(
      androidIcon: 'drawable/ic_fast_rewind',
      label: 'Previous',
      action: MediaAction.rewind,
    );

    const MediaControl fastForwardControl = MediaControl(
      androidIcon: 'drawable/ic_fast_forward',
      label: 'Next',
      action: MediaAction.fastForward,
    );

    const MediaControl stopControl = MediaControl(
      androidIcon: 'drawable/ic_stop',
      label: 'Stop',
      action: MediaAction.stop,
    );

    log('AudioPlayerTask._setState: $state ${duration?.inMilliseconds ?? position?.inMilliseconds ?? 0}');

    AudioServiceBackground.setState(
      controls: <MediaControl>[
        rewindControl,
        if (state == BasicPlaybackState.playing) pauseControl else playControl,
        fastForwardControl,
        stopControl,
      ],
      systemActions: <MediaAction>[MediaAction.seekTo],
      basicState: state,
      position: duration?.inMilliseconds ?? position?.inMilliseconds ?? 0,
    );
  }
}
