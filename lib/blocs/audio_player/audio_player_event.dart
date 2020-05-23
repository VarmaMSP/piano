part of 'audio_player_bloc.dart';

abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object> get props => <Object>[];
}

class SetQueue extends AudioPlayerEvent {
  const SetQueue({this.queue});

  final Queue queue;

  @override
  List<Object> get props => <Object>[queue];
}

class PlayEpisodeFromQueue extends AudioPlayerEvent {
  const PlayEpisodeFromQueue({this.episodeId});

  final String episodeId;

  @override
  List<Object> get props => <Object>[episodeId];
}

class PausePlayback extends AudioPlayerEvent {}

class ResumePlayback extends AudioPlayerEvent {}

class StopPlayback extends AudioPlayerEvent {}

// Internal Events
class TransistionToDormant extends AudioPlayerEvent {}

class UpdateAudioState extends AudioPlayerEvent {
  const UpdateAudioState({this.audioState});

  final audio.AudioState audioState;

  @override
  List<Object> get props => <Object>[audioState];
}
