// Package imports:
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/audio_service/audio_service.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/logger.dart';

export 'package:phenopod/service/audio_service/audio_service.dart'
    show AudioState;

enum StateTransition {
  play,
  pause,
  stop,
  fastforward,
  rewind,
}

class AudioPlayerBloc {
  final Store store;
  final AudioService audioService;
  final Logger logger = newLogger('audio_player_bloc');

  /// Stream of snapshots
  final BehaviorSubject<Queue> _queueSubject = BehaviorSubject<Queue>();

  /// Stream of positionStates
  final BehaviorSubject<PlaybackPosition> _playbackPositionSubject =
      BehaviorSubject<PlaybackPosition>();

  /// Sink for snapshot transitions
  final PublishSubject<QueueAction> _queueAction =
      PublishSubject<QueueAction>();

  /// Sink for state transitions
  final PublishSubject<StateTransition> _stateTransition =
      PublishSubject<StateTransition>();

  /// Sink for position updates
  final PublishSubject<Duration> _posistionTransition =
      PublishSubject<Duration>();

  AudioPlayerBloc(this.store, this.audioService) {
    /// Handle playback transition events
    _handleStateTransitions();

    /// Handle snapshot transition events
    _handleQueueTransitions();

    /// handle changes to position
    _handlePosistionTransitions();
  }

  void _handleStateTransitions() {
    _stateTransition.stream.listen((audioState) async {
      logger.w('stateTransition: $audioState');
      switch (audioState) {
        case StateTransition.play:
          await audioService.play();
          break;
        case StateTransition.pause:
          await audioService.pause();
          break;
        case StateTransition.stop:
          break;
        case StateTransition.fastforward:
          await audioService.fastForward();
          break;
        case StateTransition.rewind:
          await audioService.rewind();
          break;
      }
    });
  }

  void _handleQueueTransitions() {
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
        play: (data) async {
          await store.audioPlayer.saveQueue(
            prevQueue
                .addToTop(data.audioTrack)
                .playTrack(prevQueue.position + 1),
          );
          await audioService.syncNowPlaying();
        },
        addToQueueTop: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.addToTop(data.audioTrack));
          await audioService.syncQueue(startTask: false);
        },
        addToQueueBottom: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.addToBottom(data.audioTrack));
          await audioService.syncQueue(startTask: false);
        },
        changeTrackPosition: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.changeTrackPosition(data.from, data.to));
          await audioService.syncQueue(startTask: false);
        },
        playTrack: (data) async {
          await store.audioPlayer.saveQueue(prevQueue.playTrack(data.position));
          await audioService.syncQueue(startTask: false);
        },
        removeTrack: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.removeTrack(data.position));
          await audioService.syncQueue(startTask: false);
        },
        clearQueue: (data) async {
          await store.audioPlayer.saveQueue(Queue.empty());
          await audioService.stop();
        },
      );
    });
  }

  void _handlePosistionTransitions() {
    audioService.playbackPosition
        .listen((d) => _playbackPositionSubject.add(d));

    _posistionTransition.stream.listen((position) async {
      logger.i('Position transition: $position');
      await audioService.seekTo(position);
    });
  }

  // Transition state
  void Function(StateTransition) get transitionState => _stateTransition.add;

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
    await _stateTransition.close();
    await _posistionTransition.close();
    await audioService.dispose();
  }
}
