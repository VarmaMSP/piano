import 'package:logger/logger.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/audio_service/audio_service.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

export 'package:phenopod/service/audio_service/audio_service.dart'
    show AudioState, PositionState;

part 'audio_player_bloc.g.dart';

enum StateTransistion {
  play,
  pause,
  stop,
  fastforward,
  rewind,
}

@superEnum
enum _SnapshotTransistion {
  @Data(fields: [DataField<AudioTrack>('audioTrack')])
  PlayAudioTrack,
  @Data(fields: [DataField<AudioTrack>('audioTrack')])
  AddToQueueTop,
  @Data(fields: [DataField<AudioTrack>('audioTrack')])
  AddToQueueBottom,
  @object
  PlayPrevious,
  @object
  PlayNext,
}

class AudioPlayerBloc {
  final Store store;
  final AudioService audioService;
  final Logger logger = newLogger('audio_player_bloc');

  /// Stream of snapshots
  final BehaviorSubject<Queue> _queueSubject = BehaviorSubject<Queue>();

  /// Sink for snapshot transistions
  final PublishSubject<SnapshotTransistion> _snapshotTransistion =
      PublishSubject<SnapshotTransistion>();

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
    _handleSnapshotTransistions();

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

  void _handleSnapshotTransistions() {
    // Load audioplayer snapshot from db
    store.queue.watch().pipe(_queueSubject);

    // handle snapshot transistions
    _snapshotTransistion.stream.distinct().listen((t) async {
      final prevQueue = await _queueSubject.first;
      await t.when(
        playAudioTrack: (data) async {
          await store.queue.save(prevQueue.add(data.audioTrack));
          await audioService.syncNowPlaying();
        },
        addToQueueTop: (data) async {
          await store.queue.save(prevQueue.addToTop(data.audioTrack));
          await audioService.syncQueue(startTask: false);
        },
        addToQueueBottom: (data) async {
          await store.queue.save(prevQueue.addToBottom(data.audioTrack));
          await audioService.syncQueue(startTask: false);
        },
        playPrevious: (_) {},
        playNext: (_) {},
      );
    });
  }

  void _handlePosistionTransistions() {
    _posistionTransistion.stream.listen((position) async {
      logger.i('Position transistion: $position');
      await audioService.seekTo(position);
    });
  }

  // Transistion state
  void Function(StateTransistion) get transistionState => _stateTransistion.add;

  // Transisition snapshot
  void Function(SnapshotTransistion) get transistionSnapshot =>
      _snapshotTransistion.add;

  // Transistion position
  void Function(Duration) get transistionPosition => _posistionTransistion.add;

  // Get now playing track
  Stream<AudioTrack> get nowPlaying =>
      _queueSubject.stream.map((s) => s.nowPlaying);

  // Get queue if enabled
  Stream<Queue> get queue =>
      _queueSubject.stream.map((q) => q.enabled ? q : null);

  // Get current audio state
  Stream<AudioState> get audioState => audioService.audioState;

  // Get current posistion state
  Stream<PositionState> get positionState => audioService.positionState;

  Future<void> dispose() async {
    await _queueSubject.close();
    await _snapshotTransistion.close();
    await _stateTransistion.close();
    await _posistionTransistion.close();
    await audioService.dispose();
  }
}
