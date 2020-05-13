part of 'audio_player_bloc.dart';

abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();
}

class AudioPlayerInitial extends AudioPlayerState {
  @override
  List<Object> get props => [];
}

class AudioPlayerLoaded extends AudioPlayerState {
  const AudioPlayerLoaded({
    this.episode,
    this.podcast,
  });

  final Episode episode;
  final Podcast podcast;

  @override
  List<Object> get props => [episode];

  @override
  String toString() => 'AudioPlayerLoaded';
}

class AudioPlayerError extends AudioPlayerState {
  @override
  List<Object> get props => [];
}
