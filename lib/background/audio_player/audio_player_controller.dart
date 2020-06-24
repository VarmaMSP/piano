import 'dart:async';

import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store_impl.dart';
import 'package:phenopod/utils/audio_player.dart' as utils;
import 'package:phenopod/utils/utils.dart';
import 'package:rxdart/subjects.dart';
import 'package:audio_service/audio_service.dart' as audioservice;

import 'audio_player.dart';

class AudioPlayerController {
  Store _store;
  AudioPlayer _audioPlayer;

  /// Ticker to update playback position
  final Stream<int> _ticker =
      Stream<int>.periodic(Duration(seconds: 3)).asBroadcastStream();

  /// Stream of queue from db
  final BehaviorSubject<Queue> _queueSubject = BehaviorSubject<Queue>();

  /// Stream of now playing track from db
  final BehaviorSubject<AudioTrack> _nowPlayingSubject =
      BehaviorSubject<AudioTrack>();

  /// Stream of setings from db
  final BehaviorSubject<AudioPlayerSetting> _settingSubject =
      BehaviorSubject<AudioPlayerSetting>();

  /// Subscription to ticker
  StreamSubscription<dynamic> _tickerSubscription;

  AudioPlayerController({SqlDb sqlDb, HttpClient httpClient}) {
    _store = newStore(sqlDb, httpClient);
    _audioPlayer = AudioPlayer(
      onComplete: _playNext,
      onPlaying: _startPlaybackSync,
      onPaused: _stopPlaybackSync,
      onStart: _syncPlaybackStart,
    );
  }

  Future<void> start() async {
    await _audioPlayer.start();
    await syncQueue();
    await syncSetting();
    _handleStateChanges();
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
    final seekForwardTime = (await _settingSubject.first).seekForwardTime;
    await _audioPlayer.fastForwardBy(seconds: seekForwardTime);
  }

  Future<void> rewind() async {
    final seekBackwardTime = (await _settingSubject.first).seekBackwardTime;
    await _audioPlayer.rewindBy(seconds: seekBackwardTime);
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    await _queueSubject.close();
    await _nowPlayingSubject.close();
    await _settingSubject.close();
    await _tickerSubscription?.cancel();
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

  Future<void> syncSetting() async {
    final setting = await _store.preference.getAudioSetting();
    _settingSubject.add(setting);
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

  Future<void> _syncPlaybackStart(Duration duration) async {
    final nowPlaying = await _nowPlayingSubject.first;
    if (nowPlaying != null) {
      await _store.playback.save(Playback(
        episodeId: nowPlaying.episode.id,
        duration: duration,
        lastPlayedAt: '',
      ));
    }
  }

  Future<void> _syncPlayback() async {
    final nowPlaying = await _nowPlayingSubject.first;
    final playbackState = audioservice.AudioServiceBackground.state;
    if (nowPlaying != null && utils.isValidState(playbackState)) {
      await _store.playback.updateProgress(Playback(
        episodeId: nowPlaying.episode.id,
        position: playbackState.currentPosition,
      ));
    }
  }

  Future<void> _startPlaybackSync() async {
    if (_tickerSubscription == null) {
      _tickerSubscription = _ticker.listen((_) => _syncPlayback());
    } else {
      _tickerSubscription.resume();
    }
  }

  Future<void> _stopPlaybackSync() async {
    await _tickerSubscription?.cancel();
    _tickerSubscription = null;
  }

  void _handleStateChanges() {
    _nowPlayingSubject.stream.distinct().listen((audioTrack) async {
      if (audioTrack != null) {
        final playback = await _store.playback.get_(audioTrack.episode.id);
        unawaited(_audioPlayer.playMediaItem(
          audioTrack.toMediaItem(),
          start: !playback.isEmpty ? playback.position : null,
        ));
      }
    });
  }
}
