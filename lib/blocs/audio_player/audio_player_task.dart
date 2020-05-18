import 'dart:async';
import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Completer<void> _completer = Completer<void>();

  @override
  Future<void> onStart() async {
    final Stream<AudioPlaybackEvent> s = _audioPlayer.playbackEventStream;
    final StreamSubscription<AudioPlaybackEvent> updateState = s.listen(
      (AudioPlaybackEvent event) {
        log('something ${event.toString()}');
        final BasicPlaybackState state = _toBasicPlaybackState(event);
        if (state == BasicPlaybackState.error) {
          _setState(state, position: Duration.zero);
        }

        if (state != BasicPlaybackState.stopped &&
            state != BasicPlaybackState.none) {
          _setState(state, position: event.position);
        }
      },
    );

    log('onStart');

    await _completer.future;
    updateState.cancel();
  }

  @override
  Future<void> onPlayMediaItem(MediaItem mediaItem) async {
    log('on Play Media Item ${mediaItem.toString()}');
    try {
      await AudioServiceBackground.setMediaItem(mediaItem);
      await _setState(
        BasicPlaybackState.none,
        duration: await _audioPlayer.setUrl(mediaItem.id),
      );
      await onPlay();
    } catch (err) {
      log(err.toString());
      await _setState(
        BasicPlaybackState.error,
        position: Duration.zero,
      );
    }
  }

  @override
  Future<void> onPlay() async {
    await _audioPlayer.play();
  }

  @override
  Future<void> onPause() async {
    await _audioPlayer.pause();
  }

  @override
  void onClick(MediaButton button) {
    AudioServiceBackground.state.basicState == BasicPlaybackState.playing
        ? onPause()
        : onPlay();
  }

  @override
  Future<void> onStop() async {
    log('on Stop');
    await _audioPlayer.stop();
    _setState(
      BasicPlaybackState.stopped,
      position: _audioPlayer.playbackEvent.position,
    );

    await _audioPlayer.dispose();
    _completer.complete();
  }

  BasicPlaybackState _toBasicPlaybackState(AudioPlaybackEvent event) {
    if (event.buffering) {
      return BasicPlaybackState.buffering;
    }

    switch (event.state) {
      case AudioPlaybackState.none:
        return BasicPlaybackState.none;

      case AudioPlaybackState.stopped:
        return BasicPlaybackState.stopped;

      case AudioPlaybackState.paused:
        return BasicPlaybackState.paused;

      case AudioPlaybackState.playing:
        return BasicPlaybackState.playing;

      case AudioPlaybackState.connecting:
        return BasicPlaybackState.connecting;

      case AudioPlaybackState.completed:
        return BasicPlaybackState.stopped;

      default:
        return BasicPlaybackState.error;
    }
  }

  Future<void> _setState(
    BasicPlaybackState state, {
    Duration duration,
    Duration position,
  }) async {
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

    await AudioServiceBackground.setState(
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
