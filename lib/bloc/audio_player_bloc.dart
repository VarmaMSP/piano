// Package imports:
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/audio_service/audio_service.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/logger.dart';

export 'package:phenopod/service/audio_service/audio_service.dart'
    show AudioState;

class AudioPlayerBloc {
  final Store store;
  final AudioService audioService;
  final Logger logger = newLogger('audio_player_bloc');

  /// Stream of snapshots
  final BehaviorSubject<Queue> _queueSubject = BehaviorSubject<Queue>();

  /// Stream of positionStates
  final BehaviorSubject<PlaybackPosition> _playbackPositionSubject =
      BehaviorSubject<PlaybackPosition>();

  /// Sink for queue actions
  final PublishSubject<QueueAction> _queueAction =
      PublishSubject<QueueAction>();

  /// Sink for audio actions
  final PublishSubject<AudioAction> _audioAction =
      PublishSubject<AudioAction>();

  /// Sink for position updates
  final PublishSubject<Duration> _posistionTransition =
      PublishSubject<Duration>();

  AudioPlayerBloc(this.store, this.audioService) {
    /// Handle playback transition events
    _handleAudioActions();

    /// Handle snapshot transition events
    _handleQueueActions();

    /// handle changes to position
    _handlePosistionTransitions();
  }

  void _handleAudioActions() {
    _audioAction.stream.listen((audioState) async {
      logger.w('stateTransition: $audioState');
      switch (audioState) {
        case AudioAction.play:
          await audioService.play();
          break;
        case AudioAction.pause:
          await audioService.pause();
          break;
        case AudioAction.stop:
          break;
        case AudioAction.fastforward:
          await audioService.fastForward();
          break;
        case AudioAction.rewind:
          await audioService.rewind();
          break;
      }
    });
  }

  void _handleQueueActions() {
    // Load audioplayer snapshot from db
    store.audioPlayer.watchQueue().listen(_queueSubject.add);

    // set initial audio position when ever now playing changes
    _queueSubject.stream
        .map((queue) => queue.nowPlaying)
        .where((track) => track != null)
        .distinct()
        .asyncMap(
          (track) =>
              store.playbackPosition.watchByEpisode(track.episode.id).first,
        )
        .where((pos) => pos != null)
        .listen(_playbackPositionSubject.add);

    // handle queue transitions
    _queueAction.stream.listen((action) async {
      final prevQueue = await _queueSubject.first;
      await action.map(
        playTrack: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.addToTop(data.audioTrack).skipToNextTrack());
          await audioService.syncQueue();
        },
        playTrackAt: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.playTrackAt(data.position));
          await audioService.syncQueue();
        },
        addToQueueTop: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.addToTop(data.audioTrack));
          await audioService.syncQueue();
        },
        addToQueueBottom: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.addToBottom(data.audioTrack));
          await audioService.syncQueue();
        },
        changeTrackPosition: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.changeTrackPosition(data.from, data.to));
          await audioService.syncQueue();
        },
        removeTrack: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.removeTrack(data.position));
          await audioService.syncQueue();
        },
        clearQueue: (data) async {
          await store.audioPlayer.saveQueue(Queue.empty());
          await audioService.stop();
        },
      );
    });
  }

  void _handlePosistionTransitions() {
    audioService.playbackPosition.listen(
      (d) => _playbackPositionSubject.add(d),
    );

    _posistionTransition.stream.listen((position) async {
      logger.i('Position transition: $position');
      await audioService.seekTo(position);
    });
  }

  // Transition state
  void Function(AudioAction) get addAudioAction => _audioAction.add;

  // Transisition snapshot
  void Function(QueueAction) get addQueueAction => _queueAction.add;

  // Transition position
  void Function(Duration) get transitionPosition => _posistionTransition.add;

  // Get now playing track
  Stream<AudioTrack> get nowPlaying =>
      _queueSubject.stream.map((s) => s.nowPlaying);

  // Get queue if enabled
  Stream<Queue> get queue =>
      _queueSubject.stream.map((q) => !q.isEmpty ? q : null);

  // Get current audio state
  Stream<AudioState> get audioState => audioService.audioState;

  // Get current posistion state
  Stream<PlaybackPosition> get positionState => _playbackPositionSubject.stream;

  Future<void> dispose() async {
    await _queueSubject.close();
    await _playbackPositionSubject.close();
    await _queueAction.close();
    await _audioAction.close();
    await _posistionTransition.close();
    await audioService.dispose();
  }
}
