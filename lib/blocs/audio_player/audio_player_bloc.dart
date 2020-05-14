import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as AP;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:rxdart/rxdart.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AP.AudioPlayer player;

  @override
  AudioPlayerState get initialState => AudioPlayerInitial();

  @override
  Stream<AudioPlayerState> mapEventToState(
    AudioPlayerEvent event,
  ) async* {
    try {
      final state = this.state;
      // Load episode
      if (event is Load) {
        if (state is AudioPlayerLoaded &&
            state.episode.id == event.episode.id) {
          return;
        }

        player?.stop();
        player?.release();
        player = AP.AudioPlayer();
        if (await player.play(event.episode.mediaUrl) == 1) {
          yield AudioPlayerLoaded(
            episode: event.episode,
            podcast: event.podcast,
            currentTime: player.onAudioPositionChanged,
            duration: ConcatStream([
              Stream.fromIterable([Duration.zero]),
              player.onDurationChanged,
            ]),
            playerState: player.onPlayerStateChanged,
          );
        } else {
          yield AudioPlayerError();
        }
      }

      if (event is Pause) {
        await player.pause();
      }

      if (event is Play) {
        await player.resume();
      }
    } catch (err) {
      yield AudioPlayerError();
    }
  }
}
