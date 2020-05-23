import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:phenopod/blocs/audio_player/service/main.dart';
import 'package:phenopod/models/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'service/main.dart' as audio;

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc() {
    audio.stateStream.listen((audio.AudioState audioState) {
      if (audioState.isActive) {
        add(UpdateAudioState(audioState: audioState));
      } else {
        add(TransistionToDormant());
      }
    });
  }

  @override
  AudioPlayerState get initialState => const AudioPlayerDormant();

  @override
  Stream<AudioPlayerState> mapEventToState(
    AudioPlayerEvent event,
  ) async* {
    final state = this.state;

    log(event.toString());

    if (event is SetQueue) {
      if (state is AudioPlayerDormant) {
        yield AudioPlayerDormant(queue: event.queue);
      }

      if (state is AudioPlayerActive) {
        yield state.copyWith(queue: event.queue);
      }
    }

    if (event is PlayEpisodeFromQueue) {
      final queueItem = state.queue.getQueueItem(episodeId: event.episodeId);
      final mediaItem = queueItem?.toMediaItem();

      if (mediaItem != null) {
        await audio.play(mediaItem);
      }

      // starting background task takes time.
      // use this hack to show use audio_player
      if (state is AudioPlayerDormant) {
        yield AudioPlayerActive(
          queue: state.queue,
          playingNow: queueItem,
          audioState: AudioState.loadingMediaItem(mediaItem),
        );
      }
    }

    if (event is PausePlayback) {
      await audio.pause();
    }

    if (event is ResumePlayback) {
      await audio.resume();
    }

    if (event is StopPlayback) {
      await audio.stop();
    }

    if (event is TransistionToDormant) {
      if (state is AudioPlayerActive) {
        yield state.toDormant();
      }
    }

    if (event is UpdateAudioState) {
      final mediaUri = event.audioState.mediaItem.id;
      final queueItem = state.queue.getQueueItem(mediaUri: mediaUri);

      if (queueItem != null && state is AudioPlayerDormant) {
        yield AudioPlayerActive(
          queue: state.queue,
          playingNow: queueItem,
          audioState: event.audioState,
        );
      }

      if (queueItem != null && state is AudioPlayerActive) {
        yield state.copyWith(
          playingNow: queueItem,
          audioState: event.audioState,
        );
      }
    }
  }
}
