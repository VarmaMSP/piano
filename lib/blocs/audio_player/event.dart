part of 'main.dart';

abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();
}

class PlayEpisode extends AudioPlayerEvent {
  const PlayEpisode({
    this.episode,
    this.podcast,
  });

  final Episode episode;
  final Podcast podcast;

  @override
  List<Object> get props => <Object>[episode];
}

class ResumePlayback extends AudioPlayerEvent {
  @override
  List<Object> get props => <Object>[];
}

class PausePlayback extends AudioPlayerEvent {
  @override
  List<Object> get props => <Object>[];
}

class StopPlayback extends AudioPlayerEvent {
  @override
  List<Object> get props => <Object>[];
}

// Internal Events
class ResetState extends AudioPlayerEvent {
  @override
  List<Object> get props => <Object>[];
}

class UpdateActiveState extends AudioPlayerEvent {
  const UpdateActiveState({
    this.episode,
    this.podcast,
    this.duration,
    this.currentTime,
    this.playbackState,
  });

  final Episode episode;
  final Podcast podcast;
  final Duration duration;
  final Duration currentTime;
  final String playbackState;

  @override
  List<Object> get props =>
      <Object>[episode, podcast, currentTime, duration, playbackState];
}
