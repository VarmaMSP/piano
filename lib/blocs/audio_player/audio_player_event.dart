part of 'audio_player_bloc.dart';

abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();
}

class Load extends AudioPlayerEvent {
  Load({
    this.episode,
    this.podcast,
  });

  final Episode episode;
  final Podcast podcast;

  @override
  List<Object> get props => [];
}

class Play extends AudioPlayerEvent {
  @override
  List<Object> get props => [];
}

class Pause extends AudioPlayerEvent {
  @override
  List<Object> get props => [];
}
