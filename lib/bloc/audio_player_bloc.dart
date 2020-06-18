import 'dart:collection';

import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/audio/audio_service.dart';
import 'package:phenopod/store/store.dart';
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

export 'package:phenopod/service/audio/audio_service.dart' show AudioState;

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
  @object
  PlayNext,
  @object
  AddToQueue,
}

class AudioPlayerBloc {
  final Store store;

  /// Service to communicate to background audio task
  final AudioService _audioService = AudioService();

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

  AudioPlayerBloc(this.store) {
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
          await _audioService.play();
          break;
        case StateTransistion.pause:
          await _audioService.pause();
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
    // pipe updates from db directly subject
    store.audioPlayer.getSnapshot().listen((snapshot) {
      print('Sanpshot $snapshot');
      _snapshotSubject.add(snapshot);
    });

    // handle snapshot transistions
    _snapshotTransistion.stream.distinct().listen((t) async {
      final prevSnapshot = await _snapshotSubject.first;

      t.when(
        playAudioTrack: (data) {
          if (prevSnapshot == null) {
            store.audioPlayer.saveSnapshot(
              AudioPlayerSnapshot.singleTrack(data.audioTrack),
            );
          } else {
            store.audioPlayer.saveSnapshot(prevSnapshot.copyWith(
              queue: Queue(
                audioTracks: [data.audioTrack],
                position: 0,
                enabled: false,
              ),
            ));
          }
        },
        playNext: (_) {},
        addToQueue: (_) {},
      );
    });
  }

  void _handlePosistionTransistions() {
    _posistionTransistion.stream.distinct().listen((position) async {
      await _audioService.seek(position);
    });
  }

  // Transistion state
  void Function(StateTransistion) get transistionState => _stateTransistion.add;

  // Transisition snapshot
  void Function(SnapshotTransistion) get transistionSnapshot =>
      _snapshotTransistion.add;

  // get current audio player snapshot
  Stream<AudioPlayerSnapshot> get snapshot => _snapshotSubject.stream;

  // get current audio state
  Stream<AudioState> get audioState => _audioService.audioState;

  // get current posistion state
  Stream<PositionState> get positionState => _audioService.positionState;

  Future<void> dispose() async {
    await _snapshotSubject.close();
    await _snapshotTransistion.close();
    await _stateTransistion.close();
    await _audioService.dispose();
  }
}
