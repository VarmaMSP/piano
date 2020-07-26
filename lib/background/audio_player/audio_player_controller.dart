// Dart imports:
import 'dart:async';

// Package imports:
import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:rxdart/subjects.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/audio_player.dart' as utils;
import 'package:phenopod/utils/file.dart';
import 'audio_player.dart';

class AudioPlayerController {
  Store _store;
  AudioPlayer _audioPlayer;
  Future<void> Function() onQueueExhausted;

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

  AudioPlayerController({Api api, Db db, this.onQueueExhausted}) {
    _store = newStore(api, db);
    _audioPlayer = AudioPlayer(
      onComplete: () async {
        await _stopPlaybackSync();
        await _playNext();
      },
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
    final queue = await _store.audioPlayer.watchQueue().first;
    _queueSubject.add(queue);
    _nowPlayingSubject.add(queue.nowPlaying);
  }

  Future<void> syncNowPlaying() async {
    final nowPlaying = await _store.audioPlayer.watchNowPlaying().first;
    _nowPlayingSubject.add(nowPlaying);
  }

  Future<void> syncSetting() async {
    final setting = await _store.setting.watchAudioPlayerSetting().first;
    _settingSubject.add(setting);
  }

  Future<void> _playNext() async {
    final prevQueue = await _queueSubject.first;
    await _store.audioPlayer.saveQueue(
      prevQueue.skipToNextTrack().removeTrack(prevQueue.position),
    );
    await syncQueue();
  }

  Future<void> _syncPlaybackStart(Duration duration) async {
    final nowPlaying = await _nowPlayingSubject.first;
    if (nowPlaying != null) {
      await _store.playbackPosition.upsert(PlaybackPosition(
        episodeId: nowPlaying.episode.id,
        position: Duration.zero,
        duration: duration,
      ));
    }
  }

  Future<void> _syncPlayback() async {
    final nowPlaying = await _nowPlayingSubject.first;
    final playbackState = audioservice.AudioServiceBackground.state;
    if (nowPlaying != null && utils.isValidState(playbackState)) {
      await _store.playbackPosition.upsert(PlaybackPosition(
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
    _nowPlayingSubject.stream
        .distinct((prev, next) => prev?.episode?.id == next?.episode?.id)
        .listen(
      (audioTrack) async {
        if (audioTrack == null) {
          return onQueueExhausted();
        }

        final episodeId = audioTrack.episode.id;
        final audioFile =
            await _store.audioFile.watchByEpisode(episodeId).first;
        final playbackPos =
            await _store.playbackPosition.watchByEpisode(episodeId).first;

        // Check if file is deleted on disk
        if (audioFile != null && !await checkFileExists(audioFile.filepath)) {
          await _store.audioFile.deleteByEpisode(episodeId);
          await _audioPlayer.playMediaItem(
            audioTrack.toMediaItem(),
            start: playbackPos?.position,
            isFile: false,
          );
          return;
        }

        await _audioPlayer.playMediaItem(
          audioTrack.toMediaItem(filePath: audioFile?.filepath),
          start: playbackPos?.position,
          isFile: audioFile != null,
        );
      },
    );
  }
}
