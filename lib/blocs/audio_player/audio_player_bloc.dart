import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer player = AudioPlayer();

  @override
  AudioPlayerState get initialState => AudioPlayerInitial();

  @override
  Stream<AudioPlayerState> mapEventToState(
    AudioPlayerEvent event,
  ) async* {
    final AudioPlayerState state = this.state;

    try {
      // Load episode
      if (event is Load) {
        if (state is AudioPlayerLoaded) {
          player.stop();
        }

        if (await this.player.play(event.episode.mediaUrl) == 1) {
          player.onPlayerStateChanged.listen((s) {
            print('Current player state: $s');
          });

          yield AudioPlayerLoaded(
            episode: event.episode,
            podcast: event.podcast,
          );
        } else {
          yield AudioPlayerError();
        }
      }
    } catch (err) {
      yield AudioPlayerError();
    }
  }
}
