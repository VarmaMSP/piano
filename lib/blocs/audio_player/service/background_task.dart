import 'dart:async';
import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

/// * States set by AudioTask
/// * -----------------------
/// * [BasicPlaybackState.none] -> audioplayer has not loaded anything or closed
/// * [BasicPlaybackState.skippingToQueueItem] -> Using this to send duration to UI

/// * States set by AudioPlayer
/// * -------------------------
/// * [BasicPlaybackState.connecting] with duration -> duration is loaded
/// * [BasicPlaybackState.buffering] -> audio is buffering
/// * [BasicPlaybackState.paused] -> audio is paused
/// * [BasicPlaybackState.playing] -> audio is playing
/// * [BasicPlaybackState.stopped] -> audio playback is complete

void backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Completer<void> _completer = Completer<void>();

  @override
  Future<void> onStart() async {
    final eventSubscription =
        _audioPlayer.playbackEventStream.listen((AudioPlaybackEvent event) {
      // Stopping is controlled manually
      if (event.state == AudioPlaybackState.stopped ||
          event.state == AudioPlaybackState.none) {
        return;
      }

      _setState(
        _toBasicPlaybackState(event.buffering, event.state),
        position: event.position,
      );
    });

    await _completer.future;
    await eventSubscription.cancel();
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
        mediaItem.copyWith(duration: duration?.inMilliseconds),
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
