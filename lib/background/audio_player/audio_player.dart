import 'dart:async';

import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:just_audio/just_audio.dart' as justaudio;

class AudioPlayer {
  final justaudio.AudioPlayer _player = justaudio.AudioPlayer();

  bool _playing = false;
  Duration _position = Duration.zero;
  audioservice.AudioProcessingState _processingState =
      audioservice.AudioProcessingState.none;
  StreamSubscription<justaudio.AudioPlaybackEvent> _eventSubscription;

  Future<void> start() async {
    _eventSubscription = _player.playbackEventStream.listen(
      (event) async {
        _position = event.position;
        if (event.buffering) {
          _processingState = audioservice.AudioProcessingState.buffering;
        } else if (event.state == justaudio.AudioPlaybackState.connecting) {
          _processingState = audioservice.AudioProcessingState.connecting;
        } else if (event.state == justaudio.AudioPlaybackState.paused) {
          _playing = false;
          _processingState = audioservice.AudioProcessingState.ready;
        } else if (event.state == justaudio.AudioPlaybackState.playing) {
          _playing = true;
          _processingState = audioservice.AudioProcessingState.ready;
        }

        await _setState();
      },
    );
  }

  Future<void> playMediaItem(audioservice.MediaItem mediaItem) async {
    if (_canStop()) {
      await _player.stop();
    }

    await audioservice.AudioServiceBackground.setMediaItem(mediaItem);
    final duration = await _player.setUrl(mediaItem.id);
    await audioservice.AudioServiceBackground.setMediaItem(
        mediaItem.copyWith(duration: duration));

    await play();
  }

  Future<void> play() async {
    if (_canPlay()) {
      await _player.play();
    }
  }

  Future<void> pause() async {
    if (_canPause()) {
      await _player.pause();
    }
  }

  Future<void> seek(Duration position) async {
    if (_canSeek()) {
      await _player.seek(position);
    }
  }

  Future<void> pauseOrPlay() async {
    _playing ? await pause() : await play();
  }

  Future<void> stop() async {
    await _eventSubscription.cancel();
    await _player.dispose();
  }

  Future<void> _setState() async {
    await audioservice.AudioServiceBackground.setState(
      controls: [
        rewindControl,
        if (_playing) pauseControl else playControl,
        fastForwardControl,
        stopControl,
      ],
      systemActions: [audioservice.MediaAction.seekTo],
      processingState: _processingState,
      playing: _playing,
      position: _position,
    );
  }

  bool _canPause() {
    final audioPlaybackState = _player.playbackState;
    return audioPlaybackState == justaudio.AudioPlaybackState.playing;
  }

  bool _canPlay() {
    final audioPlaybackState = _player.playbackState;
    return audioPlaybackState != justaudio.AudioPlaybackState.connecting &&
        audioPlaybackState != justaudio.AudioPlaybackState.none;
  }

  bool _canStop() {
    final audioPlaybackState = _player.playbackState;
    return audioPlaybackState == justaudio.AudioPlaybackState.paused ||
        audioPlaybackState == justaudio.AudioPlaybackState.playing ||
        audioPlaybackState == justaudio.AudioPlaybackState.completed;
  }

  bool _canSeek() {
    final audioPlaybackState = _player.playbackState;
    return audioPlaybackState != justaudio.AudioPlaybackState.connecting &&
        audioPlaybackState != justaudio.AudioPlaybackState.none;
  }
}

const playControl = audioservice.MediaControl(
  androidIcon: 'drawable/ic_play_circle_outline',
  label: 'Play',
  action: audioservice.MediaAction.play,
);

const pauseControl = audioservice.MediaControl(
  androidIcon: 'drawable/ic_pause_circle_outline',
  label: 'Pause',
  action: audioservice.MediaAction.pause,
);

const rewindControl = audioservice.MediaControl(
  androidIcon: 'drawable/ic_fast_rewind',
  label: 'Previous',
  action: audioservice.MediaAction.rewind,
);

const fastForwardControl = audioservice.MediaControl(
  androidIcon: 'drawable/ic_fast_forward',
  label: 'Next',
  action: audioservice.MediaAction.fastForward,
);

const stopControl = audioservice.MediaControl(
  androidIcon: 'drawable/ic_stop',
  label: 'Stop',
  action: audioservice.MediaAction.stop,
);
