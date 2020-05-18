import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:rxdart/rxdart.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final audio.AudioPlayer player = audio.AudioPlayer();

  @override
  AudioPlayerState get initialState => AudioPlayerInitial();

  @override
  Stream<AudioPlayerState> mapEventToState(
    AudioPlayerEvent event,
  ) async* {
    try {
      final AudioPlayerState state = this.state;
      // Load episode
      if (event is Load) {
        if (state is AudioPlayerLoaded &&
            state.episode.id == event.episode.id) {
          return;
        }

        await player.stop();
        if (await player.play(event.episode.mediaUrl) == 1) {
          yield AudioPlayerLoaded(
            episode: event.episode,
            podcast: event.podcast,
            currentTime: Rx.concat(
              <Stream<Duration>>[
                Stream<Duration>.fromIterable(<Duration>[Duration.zero]),
                player.onAudioPositionChanged,
              ],
            ),
            duration: Rx.concat(
              <Stream<Duration>>[
                Stream<Duration>.fromIterable(<Duration>[Duration.zero]),
                player.onDurationChanged,
              ],
            ),
            playerState: Rx.concat<audio.AudioPlayerState>(
              <Stream<audio.AudioPlayerState>>[
                Stream<audio.AudioPlayerState>.fromIterable(
                  <audio.AudioPlayerState>[audio.AudioPlayerState.PLAYING],
                ),
                player.onPlayerStateChanged,
              ],
            ),
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
