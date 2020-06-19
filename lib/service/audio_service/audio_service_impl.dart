part of 'audio_service.dart';

class _audioServiceImpl implements AudioService {
  /// Stream of audiostate transitions
  final BehaviorSubject<AudioState> _audioState = BehaviorSubject<AudioState>();

  /// Stream for current audio position
  final BehaviorSubject<PositionState> _positionState =
      BehaviorSubject<PositionState>();

  /// Ticker to update audio position
  final Stream<int> _ticker = Stream<int>.periodic(Duration(milliseconds: 500));

  /// Subscription of _positionState to _ticker
  StreamSubscription<dynamic> _positionSubscription;

  /// Subscriptions to Background audio service
  StreamSubscription<dynamic> _playbackStateSubscription;
  StreamSubscription<dynamic> _currentMediaItemSubscription;

  _audioServiceImpl() {
    _handleAudioServiceTransitions();
  }

  @override
  Stream<AudioState> get audioState => _audioState.stream;

  @override
  Stream<PositionState> get positionState => _positionState.stream;

  @override
  Future<void> connect() async {
    await audioservice.AudioService.connect();
  }

  @override
  Future<void> disconnect() async {
    await audioservice.AudioService.disconnect();
  }

  @override
  Future<void> playEpisode(AudioTrack audioTrack) async {
    if (!audioservice.AudioService.running) {
      await _startBackgroundPlayerTask();
    }

    await audioservice.AudioService.playMediaItem(
      audioservice.MediaItem(
        id: audioTrack.episode.mediaUrl,
        artist: audioTrack.podcast.author,
        album: audioTrack.podcast.title,
        title: audioTrack.episode.title,
        artUri: '$thumbnailUrl/${audioTrack.podcast.urlParam}.jpg',
      ),
    );
  }

  @override
  Future<void> fastForward() async {}

  @override
  Future<void> rewind() async {}

  @override
  Future<void> pause() async {
    await audioservice.AudioService.pause();
  }

  @override
  Future<void> play() async {
    await audioservice.AudioService.play();
  }

  @override
  Future<void> seek(Duration position) async {
    await audioservice.AudioService.seekTo(position);
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
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidEnableQueue: true,
    );
  }

  void _handleAudioServiceTransitions() {
    _currentMediaItemSubscription =
        audioservice.AudioService.currentMediaItemStream.listen(
      (mediaItem) {
        if (mediaItem?.duration?.inSeconds ?? 0 > 0) {
          _positionState.add(
            PositionState(
              duration: mediaItem.duration,
              position: Duration.zero,
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
            break;
          case audioservice.AudioProcessingState.error:
            break;
        }
      },
    );
  }

  // Transition AudioState to buffering
  Future<void> _connecting() async {
    _audioState.add(AudioState.connecting);
  }

  // Transition AudioState to buffering
  Future<void> _buffering() async {
    _audioState.add(AudioState.buffering);
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
      _positionState.add(
        PositionState(
          duration: (await _positionState.last).duration,
          position: playbackState.currentPosition,
        ),
      );
    }
  }

  Future<void> _startTicker() async {
    _positionSubscription ??= _ticker.listen((_) async {
      await _updatePosition();
    });
  }

  Future<void> _stopTicker() async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;
  }
}

void backgroundPlayerTaskEntrypoint() {
  audioservice.AudioServiceBackground.run(() => BackgroundPlayerTask());
}
