import 'package:logger/logger.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/audio_service/audio_service.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

export 'package:phenopod/service/audio_service/audio_service.dart'
    show AudioState;

part 'audio_player_bloc.g.dart';

enum StateTransistion {
  play,
  pause,
  stop,
  fastforward,
  rewind,
}

@superEnum
enum _QueueTransistion {
  @Data(fields: [DataField<AudioTrack>('audioTrack')])
  PlayAudioTrack,
  @Data(fields: [DataField<AudioTrack>('audioTrack')])
  AddToQueueTop,
  @Data(fields: [DataField<AudioTrack>('audioTrack')])
  AddToQueueBottom,
  @Data(fields: [DataField<int>('from'), DataField<int>('to')])
  ChangeTrackPosition,
  @Data(fields: [DataField<int>('position')])
  RemoveTrack,
  @Data(fields: [DataField<int>('position')])
  PlayTrack
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

  /// Sink for snapshot transistions
  final PublishSubject<QueueTransistion> _queueTransistion =
      PublishSubject<QueueTransistion>();

  /// Sink for state transistions
  final PublishSubject<StateTransistion> _stateTransistion =
      PublishSubject<StateTransistion>();

  /// Sink for position updates
  final PublishSubject<Duration> _posistionTransistion =
      PublishSubject<Duration>();

  AudioPlayerBloc(this.store, this.audioService) {
    /// Handle playback transistion events
    _handleStateTransistions();

    /// Handle snapshot transistion events
    _handleQueueTransistions();

    /// handle changes to position
    _handlePosistionTransistions();
  }

  void _handleStateTransistions() {
    _stateTransistion.stream.listen((audioState) async {
      logger.w('stateTransistion: $audioState');
      switch (audioState) {
        case StateTransistion.play:
          await audioService.play();
          break;
        case StateTransistion.pause:
          await audioService.pause();
          break;
        case StateTransistion.stop:
          break;
        case StateTransistion.fastforward:
          await audioService.fastForward();
          break;
        case StateTransistion.rewind:
          await audioService.rewind();
          break;
      }
    });
  }

  void _handleQueueTransistions() {
    // Load audioplayer snapshot from db
    store.audioPlayer.watchQueue().listen(_queueSubject.add);

    // set initial audio position when ever now playing changes
    _queueSubject.stream
        .map((queue) => queue.nowPlaying)
        .where((track) => track != null)
        .distinct()
        .asyncMap((track) => store.playbackPosition.get_(track.episode.id))
        .where((pos) => !pos.isEmpty)
        .listen((pos) => _playbackPositionSubject.add(
              PlaybackPosition(
                duration: pos.duration,
                position: pos.position,
                percentage:
                    pos.position.inMilliseconds / pos.duration.inMilliseconds,
              ),
            ));

    // handle queue transistions
    _queueTransistion.stream.distinct().listen((t) async {
      final prevQueue = await _queueSubject.first;
      await t.when(
        playAudioTrack: (data) async {
          await store.audioPlayer.saveQueue(prevQueue.add(data.audioTrack));
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
              .saveQueue(prevQueue.changePosition(data.from, data.to));
          await audioService.syncQueue(startTask: false);
        },
        removeTrack: (data) async {
          await store.audioPlayer.saveQueue(prevQueue.remove(data.position));
          await audioService.syncQueue(startTask: false);
        },
        playTrack: (data) async {
          await store.audioPlayer.saveQueue(prevQueue.play(data.position));
          await audioService.syncQueue(startTask: false);
        },
      );
    });
  }

  void _handlePosistionTransistions() {
    audioService.playbackPosition
        .listen((d) => _playbackPositionSubject.add(d));

    _posistionTransistion.stream.listen((position) async {
      logger.i('Position transistion: $position');
      await audioService.seekTo(position);
    });
  }

  // Transistion state
  void Function(StateTransistion) get transistionState => _stateTransistion.add;

  // Transisition snapshot
  void Function(QueueTransistion) get transistionQueue => _queueTransistion.add;

  // Transistion position
  void Function(Duration) get transistionPosition => _posistionTransistion.add;

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
    await _queueTransistion.close();
    await _stateTransistion.close();
    await _posistionTransistion.close();
    await audioService.dispose();
  }
}
