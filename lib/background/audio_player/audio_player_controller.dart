import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store_impl.dart';
import 'package:phenopod/utils/request.dart';
import 'package:rxdart/subjects.dart';
import 'package:audio_service/audio_service.dart' as audioservice;

import 'audio_player.dart';

class AudioPlayerController {
  Store _store;
  AudioPlayer _audioPlayer;

  /// Stream of upto data player snapshots from db
  final BehaviorSubject<AudioPlayerSnapshot> _audioPlayerSnapshotSubject =
      BehaviorSubject<AudioPlayerSnapshot>();

  /// Stream of now playing track from db
  final BehaviorSubject<AudioTrack> _nowPlayingSubject =
      BehaviorSubject<AudioTrack>();

  AudioPlayerController({SqlDb sqlDb, HttpClient httpClient}) {
    _store = newStore(sqlDb, httpClient);
    _audioPlayer = AudioPlayer(onComplete: playNext);
  }

  Future<void> start() async {
    await _audioPlayer.start();
    _handleStateChanges();
    await syncSnapshot();
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> pauseOrPlay() async {
    await _audioPlayer.pauseOrPlay();
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seekTo(position);
  }

  Future<void> fastForward() async {
    await _audioPlayer.fastForwardBy(milliSeconds: 30000);
  }

  Future<void> rewind() async {
    await _audioPlayer.rewindBy(milliSeconds: 30000);
  }

  Future<void> playNext() async {
    final snapshot = await _audioPlayerSnapshotSubject.first;
    if (snapshot.hasNextTrack) {
      final newSnapshot = snapshot.skipToNext();
      await Future.wait([
        _store.audioPlayer.saveSnapshot(newSnapshot),
        _audioPlayer.playMediaItem(_trackToMediaItem(newSnapshot.nowPlaying)),
      ]);
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    await _audioPlayerSnapshotSubject.close();
    await _nowPlayingSubject.close();
  }

  Future<void> syncSnapshot() async {
    final snapshot = await _store.audioPlayer.getSnapshotOnce();
    _audioPlayerSnapshotSubject.add(snapshot);
    _nowPlayingSubject.add(snapshot.nowPlaying);
  }

  Future<void> syncNowPlaying() async {
    final nowPlaying = await _store.audioPlayer.getNowPlaying();
    _nowPlayingSubject.add(nowPlaying);
  }

  void _handleStateChanges() {
    _nowPlayingSubject.stream.distinct().listen((audioTrack) {
      if (audioTrack != null) {
        _audioPlayer.playMediaItem(_trackToMediaItem(audioTrack));
      }
    });
  }

  audioservice.MediaItem _trackToMediaItem(AudioTrack audioTrack) {
    return audioservice.MediaItem(
      id: audioTrack.episode.mediaUrl,
      artist: audioTrack.podcast.author,
      album: audioTrack.podcast.title,
      title: audioTrack.episode.title,
      artUri: '$thumbnailUrl/${audioTrack.podcast.urlParam}.jpg',
    );
  }
}
