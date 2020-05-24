import 'package:audio_service/audio_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'background_task.dart';

class AudioState extends Equatable {
  const AudioState({this.mediaItem, this.playbackState});

  factory AudioState.notRunning() {
    return AudioState(
      playbackState: PlaybackState(
        basicState: BasicPlaybackState.none,
        actions: {},
      ),
    );
  }

  factory AudioState.loadingMediaItem(MediaItem mediaItem) {
    return AudioState(
      mediaItem: mediaItem,
      playbackState: PlaybackState(
        basicState: BasicPlaybackState.connecting,
        actions: {},
      ),
    );
  }

  final MediaItem mediaItem;
  final PlaybackState playbackState;

  int get duration => mediaItem.duration ?? 0;
  int get currentTime => playbackState.currentPosition ?? 0;
  bool get isActive => playbackState.basicState != BasicPlaybackState.none;
  bool get isPaused => playbackState.basicState == BasicPlaybackState.paused;
  bool get isPlaying => playbackState.basicState == BasicPlaybackState.playing;
  bool get isLoading =>
      mediaItem.duration == 0 ||
      mediaItem.duration == null ||
      playbackState.basicState == BasicPlaybackState.connecting ||
      playbackState.basicState == BasicPlaybackState.buffering;

  @override
  List<Object> get props => <Object>[
        mediaItem.id,
        playbackState.basicState,
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
    notificationColor: 0xFF2196f3,
    androidNotificationIcon: 'mipmap/ic_launcher',
    enableQueue: true,
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
    await AudioService.seekTo(position);
  }
}

Future<void> stop() async {
  if (AudioService.running) {
    await AudioService.stop();
  }
}
