part of 'audio_player_bloc.dart';

abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();
}

class AudioPlayerInitial extends AudioPlayerState {
  @override
  List<Object> get props => <Object>[];
}

class AudioPlayerLoaded extends AudioPlayerState {
  const AudioPlayerLoaded({
    this.episode,
    this.podcast,
    this.currentTime,
    this.duration,
    this.playerState,
  });

  final Episode episode;
  final Podcast podcast;
  final Stream<Duration> currentTime;
  final Stream<Duration> duration;
  final Stream<audio.AudioPlayerState> playerState;

  @override
  List<Object> get props => <Object>[episode];

  @override
  String toString() => 'AudioPlayerLoaded';
}

class AudioPlayerError extends AudioPlayerState {
  @override
  List<Object> get props => <Object>[];
}