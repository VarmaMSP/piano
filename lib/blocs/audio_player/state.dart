part of 'main.dart';

abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();
}

class AudioPlayerInactive extends AudioPlayerState {
  @override
  List<Object> get props => <Object>[];

  @override
  String toString() => 'AudioPlayerInactive';
}

class AudioPlayerActive extends AudioPlayerState {
  const AudioPlayerActive({
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

  AudioPlayerActive copyWith({
    Episode episode,
    Podcast podcast,
    Duration duration,
    Duration currentTime,
    String playbackState,
  }) {
    return AudioPlayerActive(
      episode: episode ?? this.episode,
      podcast: podcast ?? this.podcast,
      duration: duration ?? this.duration,
      currentTime: currentTime ?? this.currentTime,
      playbackState: playbackState ?? this.playbackState,
    );
  }

  @override
  List<Object> get props =>
      <Object>[episode, podcast, currentTime, duration, playbackState];

  @override
  String toString() =>
      'AudioPlayerActive - ${episode.title} [${currentTime.inSeconds} | ${duration.inSeconds}]';
}

class AudioPlayerError extends AudioPlayerState {
  @override
  List<Object> get props => <Object>[];

  @override
  String toString() => 'AudioPlayerError';
}
