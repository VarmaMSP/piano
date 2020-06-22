import 'package:phenopod/store/store.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:rxdart/subjects.dart';
import 'package:audio_service/audio_service.dart' as audioservice;

import 'audio_player.dart';

class AudioPlayerController {
  final Store store;
  final AudioPlayer audioPlayer;

  final BehaviorSubject<AudioTrack> _nowPlayingSubject =
      BehaviorSubject<AudioTrack>();

  final BehaviorSubject<Queue> _queueSubject = BehaviorSubject<Queue>();

  AudioPlayerController(this.store, this.audioPlayer);

  Future<void> start() async {
    await audioPlayer.start();
    _handleStateChanges();
    await syncSnapshot();
  }

  Future<void> play() async {
    await audioPlayer.play();
  }

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> pauseOrPlay() async {
    await audioPlayer.pauseOrPlay();
  }

  Future<void> seekTo(Duration position) async {
    await audioPlayer.seekTo(position);
  }

  Future<void> fastForward() async {
    await audioPlayer.fastForwardBy(milliSeconds: 30000);
  }

  Future<void> rewind() async {
    await audioPlayer.rewindBy(milliSeconds: 30000);
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }

  Future<void> syncSnapshot() async {
    final snapshot = await store.audioPlayer.getSnapshotOnce();
    _nowPlayingSubject.add(snapshot.nowPlaying);
    _queueSubject.add(snapshot.enabledQueue);
  }

  Future<void> syncNowPlaying() async {
    final nowPlaying = await store.audioPlayer.getNowPlaying();
    _nowPlayingSubject.add(nowPlaying);
  }

  void _handleStateChanges() {
    _nowPlayingSubject.stream.distinct().listen((audioTrack) {
      if (audioTrack != null) {
        audioPlayer.playMediaItem(
          audioservice.MediaItem(
            id: audioTrack.episode.mediaUrl,
            artist: audioTrack.podcast.author,
            album: audioTrack.podcast.title,
            title: audioTrack.episode.title,
            artUri: '$thumbnailUrl/${audioTrack.podcast.urlParam}.jpg',
          ),
        );
      }
    });
  }
}
