import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phenopod/models/main.dart';
import 'audio_player_task.dart';

part 'event.dart';
part 'state.dart';

void audioPlayerTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  StreamSubscription<PlaybackState> _playbackStateListener;

  @override
  AudioPlayerState get initialState => AudioPlayerInactive();

  @override
  Stream<AudioPlayerState> mapEventToState(
    AudioPlayerEvent event,
  ) async* {
    final AudioPlayerState state = this.state;

    if (event is PlayEpisode) {
      if (state is AudioPlayerInactive) {
        await _startAudioService();
      }
      await _playEpisode(event.episode, event.podcast);

      yield AudioPlayerActive(
        episode: event.episode,
        podcast: event.podcast,
        duration: Duration.zero,
        currentTime: Duration.zero,
        playbackState: 'LOADING',
      );
    }

    if (event is ResumePlayback) {
      if (state is AudioPlayerActive) {
        await AudioService.play();
      }
      return;
    }

    if (event is PausePlayback) {
      if (state is AudioPlayerActive) {
        await AudioService.pause();
      }
      return;
    }

    if (event is StopPlayback) {
      if (state is AudioPlayerActive) {
        await AudioService.stop();
      }
      return;
    }

    if (event is ResetState) {
      yield AudioPlayerInactive();
    }

    if (event is UpdateActiveState) {
      if (state is AudioPlayerActive) {
        yield state.copyWith(
          episode: event.episode,
          podcast: event.podcast,
          duration: event.duration,
          currentTime: event.currentTime,
          playbackState: event.playbackState,
        );
      }
    }
  }

  Future<void> dispose() async {
    await _playbackStateListener?.cancel();
  }

  Future<void> _startAudioService() async {
    await AudioService.start(
      backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Phenopod',
      notificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
      enableQueue: true,
    );

    _playbackStateListener = AudioService.playbackStateStream.listen(
      (PlaybackState state) async {
        final BasicPlaybackState basicState = state?.basicState;

        if (basicState == BasicPlaybackState.buffering ||
            basicState == BasicPlaybackState.connecting ||
            basicState == BasicPlaybackState.rewinding ||
            basicState == BasicPlaybackState.fastForwarding) {
          add(
            UpdateActiveState(
              playbackState: 'LOADING',
              currentTime: Duration(milliseconds: state.currentPosition),
            ),
          );
        }

        if (basicState == BasicPlaybackState.none) {
          add(
            UpdateActiveState(
              duration: Duration(milliseconds: state.position),
            ),
          );
        }

        if (basicState == BasicPlaybackState.playing) {
          add(
            UpdateActiveState(
              playbackState: 'PLAYING',
              currentTime: Duration(milliseconds: state.currentPosition),
            ),
          );
        }

        if (basicState == BasicPlaybackState.paused) {
          add(
            UpdateActiveState(
              playbackState: 'PAUSED',
              currentTime: Duration(milliseconds: state.currentPosition),
            ),
          );
        }

        if (basicState == BasicPlaybackState.stopped) {
          await _playbackStateListener.cancel();
          add(ResetState());
        }
      },
    );
  }

  Future<void> _playEpisode(Episode episode, Podcast podcast) async {
    await AudioService.playMediaItem(MediaItem(
      id: episode.mediaUrl,
      album: podcast.title,
      title: episode.title,
      artUri: 'https://cdn.phenopod.com/thumbnails/${podcast.urlParam}.jpg',
    ));
  }
}
