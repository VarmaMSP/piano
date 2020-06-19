import 'package:phenopod/store/store.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:rxdart/subjects.dart';
import 'package:audio_service/audio_service.dart' as audioservice;

import 'audio_player.dart';

class AudioPlayerController {
  final Store store;
  final AudioPlayer audioPlayer;

  final BehaviorSubject<AudioPlayerSnapshot> _snapshotSubject =
      BehaviorSubject<AudioPlayerSnapshot>();

  final BehaviorSubject<AudioTrack> _nowPlayingSubject =
      BehaviorSubject<AudioTrack>();

  final BehaviorSubject<Queue> _queueSubject = BehaviorSubject<Queue>();

  AudioPlayerController(this.store, this.audioPlayer);

  Future<void> start() async {
    await audioPlayer.start();
    _initSubjects();
    _handleStateChanges();
  }

  Future<void> play() async {
    await audioPlayer.play();
  }

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> seekTo(Duration position) async {
    await audioPlayer.seekTo(position);
  }

  Future<void> pauseOrPlay() async {
    await audioPlayer.pauseOrPlay();
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }

  Future<void> playTrack() async {
    final snapshot = await store.audioPlayer.getSnapshotOnce();
    _nowPlayingSubject.add(snapshot.nowPlaying);
  }

  void _initSubjects() {
    /// Pipe snapshot from db into _snapshotSubject
    store.audioPlayer.getSnapshot().pipe(_snapshotSubject);

    /// pipe nowPlaying into _nowPlayingSubject
    _snapshotSubject
        .map((snapshot) => snapshot.nowPlaying)
        .distinct()
        .pipe(_nowPlayingSubject);

    /// pipe queue into _queueSubject
    _snapshotSubject
        .map((snapshot) => snapshot.enabledQueue)
        .distinct()
        .pipe(_queueSubject);
  }

  void _handleStateChanges() {
    _nowPlayingSubject.listen((audioTrack) {
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
