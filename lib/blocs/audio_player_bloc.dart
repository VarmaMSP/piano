// Package imports:
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/audio_service/audio_service.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/logger.dart';

export 'package:phenopod/services/audio_service/audio_service.dart'
    show AudioState;

class AudioPlayerBloc {
  final Store store;
  final AudioService audioService;
  final Logger logger = newLogger('audio_player_bloc');

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
    _audioAction.stream.listen((audioAction) async {
      logger.w('stateTransition: $audioAction');
      switch (audioAction) {
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
    // set initial audio position when ever now playing changes
    store.audioPlayer
        .watchQueue()
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
      final prevQueue = store.audioPlayer.getQueue();
      await action.map(
        playTrack: (data) async {
          final trackInQueue = prevQueue.audioTracks.firstWhere(
            (track) => track.episode.id == data.audioTrack.episode.id,
            orElse: () => null,
          );
          await store.audioPlayer.saveQueue(
            trackInQueue != null
                ? prevQueue.playTrackAt(trackInQueue.position)
                : prevQueue.addToTop(data.audioTrack).skipToNextTrack(),
          );
          await audioService.syncQueue(startTask: true);
        },
        playTrackAt: (data) async {
          await store.audioPlayer
              .saveQueue(prevQueue.playTrackAt(data.position));
          await audioService.syncQueue(startTask: true);
        },
        addToQueueTop: (data) async {
          if (data.audioTrack.episode.id != prevQueue.nowPlaying?.episode?.id) {
            return;
          }
          final trackInQueue = prevQueue.audioTracks.firstWhere(
            (track) => track.episode.id == data.audioTrack.episode.id,
            orElse: () => null,
          );
          await store.audioPlayer.saveQueue(
            trackInQueue != null
                ? prevQueue
                    .removeTrack(trackInQueue.position)
                    .addToTop(data.audioTrack)
                : prevQueue.addToTop(data.audioTrack),
          );
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

  // Get current audio state
  Stream<AudioState> get audioState => audioService.audioState;

  // Get current posistion state
  Stream<PlaybackPosition> get positionState => _playbackPositionSubject.stream;

  Future<void> dispose() async {
    await _playbackPositionSubject.close();
    await _queueAction.close();
    await _audioAction.close();
    await _posistionTransition.close();
    await audioService.dispose();
  }
}
