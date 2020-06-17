import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/audio/audio_service.dart';
import 'package:rxdart/subjects.dart';

enum StateTransistion {
  play,
  pause,
  stop,
  fastforward,
  rewind,
}

class AudioPlayerBloc {
  /// Service to communicate to background audio task
  final AudioService _audioService = AudioService();

  /// Conroller for currently playing item
  final BehaviorSubject<AudioTrack> _playSubject =
      BehaviorSubject<AudioTrack>();

  /// Sink to transistion states
  final PublishSubject<StateTransistion> _stateTransistion =
      PublishSubject<StateTransistion>();

  /// Sink to update position
  final PublishSubject<Duration> _posistionTransistion =
      PublishSubject<Duration>();

  AudioPlayerBloc() {
    /// Handle requests to play episodes
    _handlePlayRequests();

    /// Handle playback transistion events
    _handleStateTransistions();

    /// handle changes to position
    _handlePosistionTransistions();
  }

  void _handlePlayRequests() {
    _playSubject.stream.distinct().listen((audioTrack) {
      _audioService.playEpisode(audioTrack);
    });
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

  void _handlePosistionTransistions() {
    _posistionTransistion.stream.distinct().listen((position) async {
      await _audioService.seek(position);
    });
  }

  // Play Specified track
  void Function(AudioTrack) get play => _playSubject.add;

  // Transistion state
  void Function(StateTransistion) get transistionState => _stateTransistion.add;

  // get current playing item
  Stream<AudioTrack> get nowPlaying => _playSubject.stream;

  // get current audio state
  Stream<AudioState> get audioState => _audioService.audioState;

  // get current posistion state
  Stream<PositionState> get positionState => _audioService.positionState;

  Future<void> dispose() async {
    await _playSubject.close();
    await _stateTransistion.close();
    await _audioService.dispose();
  }
}
