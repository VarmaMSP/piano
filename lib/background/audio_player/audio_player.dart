import 'dart:async';

import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart' as justaudio;
import 'package:phenopod/utils/audio_player.dart' as utils;

class AudioPlayer {
  final justaudio.AudioPlayer _player = justaudio.AudioPlayer();
  final Future<void> Function() onComplete;
  final Future<void> Function() onPlaying;
  final Future<void> Function() onPaused;
  final Future<void> Function(Duration) onStart;

  StreamSubscription<justaudio.AudioPlaybackEvent> _eventSubscription;

  AudioPlayer({
    @required this.onComplete,
    @required this.onPlaying,
    @required this.onPaused,
    @required this.onStart,
  });

  Future<void> start() async {
    _eventSubscription = _player.playbackEventStream.listen(
      (event) async {
        if (event.buffering) {
          return utils.setState(
            position: event.position,
            processingState: audioservice.AudioProcessingState.buffering,
          );
        }

        switch (event.state) {
          case justaudio.AudioPlaybackState.none:
            return;
          case justaudio.AudioPlaybackState.stopped:
            return;
          case justaudio.AudioPlaybackState.paused:
            await onPaused();
            return utils.setState(
              playing: false,
              position: event.position,
              processingState: audioservice.AudioProcessingState.ready,
            );

          case justaudio.AudioPlaybackState.playing:
            await onPlaying();
            return utils.setState(
              playing: true,
              position: event.position,
              processingState: audioservice.AudioProcessingState.ready,
            );

          case justaudio.AudioPlaybackState.connecting:
            return utils.setState(
              position: event.position,
              processingState: audioservice.AudioProcessingState.connecting,
            );

          case justaudio.AudioPlaybackState.completed:
            await onPaused();
            return onComplete();
        }
      },
    );

    // Set default state when start up
    await utils.setState(
      playing: false,
      position: Duration.zero,
      processingState: audioservice.AudioProcessingState.none,
    );
  }

  Future<void> playMediaItem(
    audioservice.MediaItem mediaItem, {
    Duration start,
  }) async {
    if (utils.canStop(_player.playbackState)) {
      await _player.stop();
    }

    await audioservice.AudioServiceBackground.setMediaItem(mediaItem);
    final duration = await _player.setUrl(mediaItem.id);
    if (start != null) {
      await _player.seek(start);
    }
    await onStart(duration);
    await audioservice.AudioServiceBackground.setMediaItem(
      mediaItem.copyWith(duration: duration),
    );

    await play();
  }

  Future<void> skipTo(audioservice.MediaItem mediaItem) async {
    if (mediaItem == null) {
      return;
    }
    await utils.setState(
      playing: false,
      position: Duration.zero,
      processingState: audioservice.AudioProcessingState.skippingToQueueItem,
    );
    await playMediaItem(mediaItem);
  }

  Future<void> play() async {
    if (utils.canPlay(_player.playbackState)) {
      await _player.play();
    }
  }

  Future<void> pause() async {
    if (utils.canPause(_player.playbackState)) {
      await _player.pause();
    }
  }

  Future<void> pauseOrPlay() async {
    final currentState = audioservice.AudioServiceBackground.state;
    currentState.playing ? await pause() : await play();
  }

  Future<void> seekTo(Duration position) async {
    if (utils.canSeek(_player.playbackState)) {
      final currentState = audioservice.AudioServiceBackground.state;
      await _player.seek(position);
      currentState.playing ? await play() : await pause();
    }
  }

  Future<void> fastForwardBy({int milliSeconds}) async {
    final state = audioservice.AudioServiceBackground.state;
    if (!utils.isValidState(state)) {
      return;
    }
    final position = state.currentPosition;
    final newPosition = Duration(
      milliseconds: position.inMilliseconds + milliSeconds,
    );
    await seekTo(newPosition);
  }

  Future<void> rewindBy({int milliSeconds}) async {
    final state = audioservice.AudioServiceBackground.state;
    if (!utils.isValidState(state)) {
      return;
    }
    final position = state?.currentPosition;
    final newPosition = Duration(
      milliseconds: position.inMilliseconds - milliSeconds,
    );
    await seekTo(newPosition.isNegative ? Duration.zero : newPosition);
  }

  Future<void> stop() async {
    await _eventSubscription.cancel();
    await _player.dispose();
    await utils.setState(
      playing: false,
      processingState: audioservice.AudioProcessingState.stopped,
    );
  }
}
