part of 'audio_service.dart';

class _audioServiceImpl implements AudioService {
  /// Stream of current audio state
  final BehaviorSubject<AudioState> _audioState = BehaviorSubject<AudioState>();

  /// Stream of current audio position
  final BehaviorSubject<PlaybackPosition> _playbackPosition =
      BehaviorSubject<PlaybackPosition>();

  /// Ticker to update audio position
  final Stream<int> _ticker =
      Stream<int>.periodic(Duration(milliseconds: 500)).asBroadcastStream();

  /// Subscription of _playbackPosition to _ticker
  StreamSubscription<dynamic> _positionSubscription;

  /// Subscriptions to Background audio service
  StreamSubscription<dynamic> _playbackStateSubscription;
  StreamSubscription<dynamic> _currentMediaItemSubscription;

  _audioServiceImpl() {
    _handleBackgroundStateChanges();
  }

  @override
  Stream<AudioState> get audioState => _audioState.stream;

  @override
  Stream<PlaybackPosition> get playbackPosition => _playbackPosition.stream;

  @override
  Future<void> connect() async {
    await audioservice.AudioService.connect();
  }

  @override
  Future<void> disconnect() async {
    await audioservice.AudioService.disconnect();
  }

  @override
  Future<void> stop() async {
    await audioservice.AudioService.stop();
  }

  @override
  Future<void> syncQueue({bool startTask = false}) async {
    if (audioservice.AudioService.running) {
      await audioservice.AudioService.customAction('syncQueue');
    } else if (startTask) {
      await _startBackgroundPlayerTask();
    }
  }

  @override
  Future<void> syncSetting({bool startTask = false}) async {
    if (audioservice.AudioService.running) {
      await audioservice.AudioService.customAction('syncSetting');
    }
  }

  @override
  Future<void> pause() async {
    await audioservice.AudioService.pause();
  }

  @override
  Future<void> play() async {
    if (!audioservice.AudioService.running) {
      await _startBackgroundPlayerTask();
    } else {
      await audioservice.AudioService.play();
    }
  }

  @override
  Future<void> seekTo(Duration t) async {
    final prevPlaybackPos = await _playbackPosition.first;
    final duration = prevPlaybackPos.duration;

    if (duration.inSeconds > 0) {
      // relay back new position to bloc
      _playbackPosition.add(PlaybackPosition(
        duration: duration,
        position: t,
        percentage: t.inMilliseconds / duration.inMilliseconds,
      ));
      await audioservice.AudioService.seekTo(t);
    }
  }

  @override
  Future<void> fastForward() async {
    await audioservice.AudioService.fastForward();
  }

  @override
  Future<void> rewind() async {
    await audioservice.AudioService.rewind();
  }

  @override
  Future<void> dispose() async {
    await _positionSubscription?.cancel();
    await _playbackStateSubscription?.cancel();
    await _currentMediaItemSubscription?.cancel();
  }

  Future<void> _startBackgroundPlayerTask() async {
    await audioservice.AudioService.start(
      backgroundTaskEntrypoint: backgroundPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Phenopod',
      androidNotificationColor: 0xFF2196f3,
      androidStopForegroundOnPause: true,
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidEnableQueue: true,
      params: <String, dynamic>{},
    );
  }

  /// Map background streams to our custom streams
  void _handleBackgroundStateChanges() {
    _currentMediaItemSubscription =
        audioservice.AudioService.currentMediaItemStream.listen(
      (mediaItem) {
        if ((mediaItem?.duration?.inSeconds ?? 0) > 0) {
          _playbackPosition.add(
            PlaybackPosition(
              duration: mediaItem.duration,
              position: Duration.zero,
              percentage: 0.0,
            ),
          );
        }
      },
    );

    _playbackStateSubscription =
        audioservice.AudioService.playbackStateStream.listen(
      (state) async {
        switch (state?.processingState) {
          case audioservice.AudioProcessingState.none:
            await _started();
            break;
          case audioservice.AudioProcessingState.connecting:
            await _connecting();
            break;
          case audioservice.AudioProcessingState.ready:
            state.playing ? await _playing() : await _paused();
            break;
          case audioservice.AudioProcessingState.buffering:
            await _buffering();
            break;
          case audioservice.AudioProcessingState.fastForwarding:
            await _updatePosition();
            break;
          case audioservice.AudioProcessingState.rewinding:
            await _updatePosition();
            break;
          case audioservice.AudioProcessingState.skippingToPrevious:
            break;
          case audioservice.AudioProcessingState.skippingToNext:
            break;
          case audioservice.AudioProcessingState.skippingToQueueItem:
            break;
          case audioservice.AudioProcessingState.completed:
            break;
          case audioservice.AudioProcessingState.stopped:
            await _paused();
            break;
          case audioservice.AudioProcessingState.error:
            break;
        }
      },
    );
  }

  // Background servicehas just started
  Future<void> _started() async {
    _audioState.add(AudioState.none);
    await _updatePosition();
  }

  // Transition AudioState to buffering
  Future<void> _connecting() async {
    _audioState.add(AudioState.connecting);
    await _updatePosition();
  }

  // Transition AudioState to buffering
  Future<void> _buffering() async {
    _audioState.add(AudioState.buffering);
    await _updatePosition();
  }

  //  Transition AudioState to playing
  Future<void> _playing() async {
    _audioState.add(AudioState.playing);
    await _startTicker();
  }

  // Transition AudioState to paused
  Future<void> _paused() async {
    _audioState.add(AudioState.paused);
    await _stopTicker();
  }

  // Update Audio position
  Future<void> _updatePosition() async {
    final playbackState = audioservice.AudioService.playbackState;

    if (playbackState != null) {
      final duration = (await _playbackPosition.first).duration;
      final position = duration.inSeconds == 0
          ? Duration.zero
          : playbackState.currentPosition;
      final percentage = duration.inSeconds == 0
          ? 0.0
          : position.inMilliseconds / duration.inMilliseconds;

      _playbackPosition.add(
        PlaybackPosition(
          duration: duration,
          position: playbackState.currentPosition,
          percentage: percentage,
        ),
      );
    }
  }

  Future<void> _startTicker() async {
    if (_positionSubscription == null) {
      _positionSubscription = _ticker.listen((_) async {
        await _updatePosition();
      });
    } else {
      _positionSubscription.resume();
    }
  }

  Future<void> _stopTicker() async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;
  }
}

void backgroundPlayerTaskEntrypoint() {
  audioservice.AudioServiceBackground.run(() => BackgroundPlayerTask());
}
