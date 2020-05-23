import 'package:audio_service/audio_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'background_task.dart';

class AudioState extends Equatable {
  const AudioState({this.mediaItem, this.playbackState});

  final MediaItem mediaItem;
  final PlaybackState playbackState;

  bool get isActive => playbackState.basicState != BasicPlaybackState.none;

  int get duration => mediaItem?.duration ?? 0;

  bool get isPaused => playbackState?.basicState == BasicPlaybackState.paused;

  bool get isPlaying => playbackState?.basicState == BasicPlaybackState.playing;

  bool get isLoading =>
      playbackState?.basicState == BasicPlaybackState.connecting ||
      playbackState?.basicState == BasicPlaybackState.buffering;

  @override
  List<Object> get props => <Object>[mediaItem.id, playbackState?.basicState];
}

Stream<AudioState> stateStream =
    Rx.combineLatest2<MediaItem, PlaybackState, AudioState>(
  AudioService.currentMediaItemStream,
  AudioService.playbackStateStream,
  (mediaItem, playbackState) {
    if (mediaItem == null && playbackState == null) {
      return AudioState(
        playbackState: PlaybackState(
          basicState: BasicPlaybackState.none,
          actions: {},
        ),
      );
    }

    if (mediaItem != null && playbackState == null) {
      return AudioState(
        mediaItem: mediaItem,
        playbackState: PlaybackState(
          basicState: BasicPlaybackState.connecting,
          actions: {},
        ),
      );
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

Future<void> stop() async {
  if (AudioService.running) {
    await AudioService.stop();
  }
}
