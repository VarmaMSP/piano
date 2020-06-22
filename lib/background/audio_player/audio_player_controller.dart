import 'dart:async';

import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store_impl.dart';
import 'package:phenopod/utils/audio_player.dart' as utils;
import 'package:rxdart/subjects.dart';
import 'package:audio_service/audio_service.dart' as audioservice;

import 'audio_player.dart';

class AudioPlayerController {
  Store _store;
  AudioPlayer _audioPlayer;

  /// Ticker to update playback position
  final Stream<int> _ticker =
      Stream<int>.periodic(Duration(seconds: 3)).asBroadcastStream();

  /// Subscription to ticker
  StreamSubscription<dynamic> _tickerSubscription;

  /// Stream of upto data player snapshots from db
  final BehaviorSubject<Queue> _queueSubject = BehaviorSubject<Queue>();

  /// Stream of now playing track from db
  final BehaviorSubject<AudioTrack> _nowPlayingSubject =
      BehaviorSubject<AudioTrack>();

  AudioPlayerController({SqlDb sqlDb, HttpClient httpClient}) {
    _store = newStore(sqlDb, httpClient);
    _audioPlayer = AudioPlayer(
      onComplete: _playNext,
      onPlaying: _startPlaybackSync,
      onPaused: _stopPlaybackSync,
    );
  }

  Future<void> start() async {
    await _audioPlayer.start();
    _handleStateChanges();
    await syncQueue();
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

  Future<void> stop() async {
    await _audioPlayer.stop();
    await _queueSubject.close();
    await _nowPlayingSubject.close();
    await _tickerSubscription.cancel();
  }

  Future<void> syncQueue() async {
    final queue = await _store.queue.get_();
    _queueSubject.add(queue);
    _nowPlayingSubject.add(queue.nowPlaying);
  }

  Future<void> syncNowPlaying() async {
    final nowPlaying = await _store.queue.getNowPlaying();
    _nowPlayingSubject.add(nowPlaying);
  }

  Future<void> _playNext() async {
    final queue = await _queueSubject.first;
    if (queue.hasNextTrack) {
      final newQueue = queue.skipToNext();
      await Future.wait([
        _store.queue.save(newQueue),
        _audioPlayer.playMediaItem(newQueue.nowPlaying.toMediaItem()),
      ]);
    }
  }

  Future<void> _syncPlayback() async {
    final nowPlaying = await _nowPlayingSubject.first;
    final playbackState = audioservice.AudioServiceBackground.state;
    if (nowPlaying != null && utils.isValidState(playbackState)) {
      await _store.playback.save(Playback(
        episodeId: nowPlaying.episode.id,
        progress: 0,
        duration: 0,
      ));
    }
  }

  Future<void> _startPlaybackSync() async {
    if (_tickerSubscription == null) {
      _tickerSubscription = _ticker.listen((_) async {
        await _syncPlayback();
      });
    } else {
      _tickerSubscription.resume();
    }
  }

  Future<void> _stopPlaybackSync() async {
    await _tickerSubscription?.cancel();
    _tickerSubscription = null;
  }

  void _handleStateChanges() {
    _nowPlayingSubject.stream.distinct().listen((audioTrack) {
      if (audioTrack != null) {
        _audioPlayer.playMediaItem(audioTrack.toMediaItem());
      }
    });
  }
}
