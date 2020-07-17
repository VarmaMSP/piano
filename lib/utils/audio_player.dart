// Package imports:
import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:just_audio/just_audio.dart' as justaudio;

const _playControl = audioservice.MediaControl(
  androidIcon: 'drawable/ic_play_circle_outline',
  label: 'Play',
  action: audioservice.MediaAction.play,
);

const _pauseControl = audioservice.MediaControl(
  androidIcon: 'drawable/ic_pause_circle_outline',
  label: 'Pause',
  action: audioservice.MediaAction.pause,
);

const _rewindControl = audioservice.MediaControl(
  androidIcon: 'drawable/ic_fast_rewind',
  label: 'Previous',
  action: audioservice.MediaAction.rewind,
);

const _fastForwardControl = audioservice.MediaControl(
  androidIcon: 'drawable/ic_fast_forward',
  label: 'Next',
  action: audioservice.MediaAction.fastForward,
);

const _stopControl = audioservice.MediaControl(
  androidIcon: 'drawable/ic_stop',
  label: 'Stop',
  action: audioservice.MediaAction.stop,
);

const _playingControls = [
  _rewindControl,
  _pauseControl,
  _fastForwardControl,
  _stopControl,
];

const _pausedControls = [
  _rewindControl,
  _playControl,
  _fastForwardControl,
  _stopControl,
];

/// Sets new [audioservice.PlaybackState] with [playing, position, processingState]
/// If one or more values are not provided, the corresponding values from prevState
/// are used
Future<void> setState({
  bool playing,
  Duration position,
  audioservice.AudioProcessingState processingState,
}) async {
  final currentState = audioservice.AudioServiceBackground.state;
  await audioservice.AudioServiceBackground.setState(
    processingState: processingState ??
        currentState.processingState ??
        audioservice.AudioProcessingState.none,
    playing: playing ?? currentState.playing ?? false,
    position: position ?? currentState.position ?? Duration.zero,
    systemActions: [audioservice.MediaAction.seekTo],
    controls: (playing ?? currentState.playing ?? false)
        ? _playingControls
        : _pausedControls,
    updateTime: position != null
        ? Duration(milliseconds: DateTime.now().millisecondsSinceEpoch)
        : currentState.updateTime,
  );
}

/// Checks if player can be paused from given state
bool canPause(justaudio.AudioPlaybackState audioPlaybackState) {
  return audioPlaybackState == justaudio.AudioPlaybackState.playing;
}

/// Checks if player can be played from given state
bool canPlay(justaudio.AudioPlaybackState audioPlaybackState) {
  return audioPlaybackState != justaudio.AudioPlaybackState.connecting &&
      audioPlaybackState != justaudio.AudioPlaybackState.none;
}

/// Checks if player can be stopped from given state
bool canStop(justaudio.AudioPlaybackState audioPlaybackState) {
  return audioPlaybackState == justaudio.AudioPlaybackState.paused ||
      audioPlaybackState == justaudio.AudioPlaybackState.playing ||
      audioPlaybackState == justaudio.AudioPlaybackState.completed;
}

/// Checks if player can be seeked from given state
bool canSeek(justaudio.AudioPlaybackState audioPlaybackState) {
  return audioPlaybackState != justaudio.AudioPlaybackState.connecting &&
      audioPlaybackState != justaudio.AudioPlaybackState.none;
}

/// Checks if currentTime can be called on given [audioservice.PlaybackState]
bool isValidState(audioservice.PlaybackState state) {
  return state.position != null &&
      state.updateTime != null &&
      state.speed != null;
}
