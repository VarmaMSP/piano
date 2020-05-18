part of 'audio_player_bloc.dart';

abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();
}

class Load extends AudioPlayerEvent {
  const Load({
    this.episode,
    this.podcast,
  });

  final Episode episode;
  final Podcast podcast;

  @override
  List<Object> get props => <Object>[];
}

class Play extends AudioPlayerEvent {
  @override
  List<Object> get props => <Object>[];
}

class Pause extends AudioPlayerEvent {
  @override
  List<Object> get props => <Object>[];
}
