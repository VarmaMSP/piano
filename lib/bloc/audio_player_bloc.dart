import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/audio_service/audio_service.dart';
import 'package:phenopod/store/store.dart';
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

  /// Stream of snapshots
  final BehaviorSubject<AudioPlayerSnapshot> _snapshotSubject =
      BehaviorSubject<AudioPlayerSnapshot>();

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
    _stateTransistion.stream.distinct().listen((newState) async {
      switch (newState) {
        case StateTransistion.play:
          await audioService.play();
          break;
        case StateTransistion.pause:
          await audioService.pause();
          break;
        case StateTransistion.stop:
          break;
        case StateTransistion.fastforward:
          break;
        case StateTransistion.rewind:
          break;
      }
    });
  }

  void _handleSnapshotTransistions() {
    // Load audioplayer snapshot from db
    store.audioPlayer.getSnapshot().pipe(_snapshotSubject);

    // handle snapshot transistions
    _snapshotTransistion.stream.distinct().listen((t) async {
      final prevSnapshot = await _snapshotSubject.first;
      t.when(
        playAudioTrack: (data) {
          prevSnapshot.add(data.audioTrack);
        },
        addToQueueTop: (data) {
          prevSnapshot.addToQueueTop(data.audioTrack);
        },
        addToQueueBottom: (data) {
          prevSnapshot.addToQueueBottom(data.audioTrack);
        },
        playPrevious: (_) {},
        playNext: (_) {},
      );
    });
  }

  void _handlePosistionTransistions() {
    _posistionTransistion.stream.distinct().listen((position) async {
      await audioService.seek(position);
    });
  }

  // Transistion state
  void Function(StateTransistion) get transistionState => _stateTransistion.add;

  // Transisition snapshot
  void Function(SnapshotTransistion) get transistionSnapshot =>
      _snapshotTransistion.add;

  // get now playing track
  Stream<AudioTrack> get nowPlaying =>
      _snapshotSubject.stream.map((s) => s.nowPlaying);

  // get queue
  Stream<Queue> get queue => _snapshotSubject.stream.map((s) => s.enabledQueue);

  // get current audio state
  Stream<AudioState> get audioState => audioService.audioState;

  // get current posistion state
  Stream<PositionState> get positionState => audioService.positionState;

  Future<void> dispose() async {
    await _snapshotSubject.close();
    await _snapshotTransistion.close();
    await _stateTransistion.close();
    await audioService.dispose();
  }
}
