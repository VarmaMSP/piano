part of 'audio_player_bloc.dart';

abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState({
    this.queue = const Queue(),
    this.playingNow,
    this.audioState,
  });

  final Queue queue;
  final QueueItem playingNow;
  final audio.AudioState audioState;

  @override
  List<Object> get props => <Object>[queue, playingNow, audioState];
}

class AudioPlayerDormant extends AudioPlayerState {
  const AudioPlayerDormant({
    Queue queue,
    QueueItem playingNow,
    audio.AudioState audioState,
  }) : super(queue: queue, playingNow: playingNow, audioState: audioState);

  @override
  String toString() => 'AudioPlayerDormant';
}

class AudioPlayerActive extends AudioPlayerState {
  const AudioPlayerActive({
    Queue queue,
    QueueItem playingNow,
    audio.AudioState audioState,
  }) : super(queue: queue, playingNow: playingNow, audioState: audioState);

  AudioPlayerActive copyWith({
    Queue queue,
    QueueItem playingNow,
    audio.AudioState audioState,
  }) {
    return AudioPlayerActive(
      queue: queue ?? this.queue,
      playingNow: playingNow ?? this.playingNow,
      audioState: audioState ?? this.audioState,
    );
  }

  AudioPlayerDormant toDormant() {
    return AudioPlayerDormant(
      queue: queue,
      playingNow: playingNow,
      audioState: audioState,
    );
  }

  @override
  String toString() => 'AudioPlayerActive';
}

class AudioPlayerError extends AudioPlayerState {
  const AudioPlayerError({
    Queue queue,
    QueueItem playingNow,
    audio.AudioState audioState,
  }) : super(queue: queue, playingNow: playingNow, audioState: audioState);

  @override
  List<Object> get props => <Object>[];

  @override
  String toString() => 'AudioPlayerDormant';
}
