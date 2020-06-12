import 'package:audio_service/audio_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'background_task.dart';

class AudioState extends Equatable {
  const AudioState({this.mediaItem, this.playbackState});

  factory AudioState.notRunning() {
    return AudioState(
      playbackState: PlaybackState(
        processingState: AudioProcessingState.none,
        playing: false,
        actions: {},
      ),
    );
  }

  factory AudioState.loadingMediaItem(MediaItem mediaItem) {
    return AudioState(
      mediaItem: mediaItem,
      playbackState: PlaybackState(
        processingState: AudioProcessingState.connecting,
        playing: false,
        actions: {},
      ),
    );
  }

  final MediaItem mediaItem;
  final PlaybackState playbackState;

  int get duration => mediaItem.duration?.inMilliseconds ?? 0;
  int get currentTime => playbackState.currentPosition?.inMilliseconds ?? 0;
  bool get isActive =>
      playbackState.processingState != AudioProcessingState.none;
  bool get isPaused =>
      playbackState.processingState == AudioProcessingState.ready;
  bool get isPlaying =>
      playbackState.playing &&
      playbackState.processingState == AudioProcessingState.ready;
  bool get isLoading =>
      mediaItem.duration == Duration.zero ||
      mediaItem.duration == null ||
      playbackState.processingState == AudioProcessingState.connecting ||
      playbackState.processingState == AudioProcessingState.buffering;

  @override
  List<Object> get props => <Object>[
        mediaItem.id,
        playbackState.processingState,
        playbackState.position,
        playbackState.updateTime
      ];
}

Stream<AudioState> stateStream =
    Rx.combineLatest2<MediaItem, PlaybackState, AudioState>(
  AudioService.currentMediaItemStream,
  AudioService.playbackStateStream,
  (mediaItem, playbackState) {
    if (mediaItem == null && playbackState == null) {
      return AudioState.notRunning();
    }

    if (mediaItem != null && playbackState == null) {
      return AudioState.loadingMediaItem(mediaItem);
    }

    if (mediaItem != null && playbackState != null) {
      return AudioState(mediaItem: mediaItem, playbackState: playbackState);
    }

    return null;
  },
).where((x) => x != null);

Future<void> start() async {
  await AudioService.start(
    backgroundTaskEntrypoint: backgroundTaskEntrypoint,
    androidNotificationChannelName: 'Phenopod',
    androidNotificationColor: 0xFF2196f3,
    androidNotificationIcon: 'mipmap/ic_launcher',
    androidEnableQueue: true,
  );
}

Future<void> play(MediaItem mediaItem) async {
  if (!AudioService.running) {
    await start();
  }
  await AudioService.playMediaItem(mediaItem);
}

Future<void> pause() async {
  if (AudioService.running) {
    await AudioService.pause();
  }
}

Future<void> resume() async {
  if (AudioService.running) {
    await AudioService.play();
  }
}

Future<void> seekTo(int position) async {
  if (AudioService.running) {
    await AudioService.seekTo(Duration(milliseconds: position));
  }
}

Future<void> stop() async {
  if (AudioService.running) {
    await AudioService.stop();
  }
}
