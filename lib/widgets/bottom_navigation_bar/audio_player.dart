import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/audio_player/audio_player_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:audioplayers/audioplayers.dart' as AP;

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      bloc: audioPlayerBloc,
      builder: (context, state) {
        if (state is AudioPlayerInitial) {
          return Container(height: 0);
        }

        final s = state as AudioPlayerLoaded;
        return Container(
          height: 50,
          padding: EdgeInsets.only(left: 16, right: 16),
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.expand_less,
                color: TWColors.gray.shade800,
                size: 22,
              ),
              Container(width: 10.0),
              Expanded(
                child: Text(
                  s.episode.title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              SizedBox(
                height: 31,
                width: 31,
                child: Stack(
                  children: <Widget>[
                    _buildCircularProgressIndicator(s),
                    _buildActionButton(audioPlayerBloc, s),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCircularProgressIndicator(AudioPlayerLoaded state) {
    return StreamBuilder<Duration>(
      stream: state.duration,
      initialData: Duration.zero,
      builder: (context, snapshot) {
        final duration = snapshot.data.inSeconds;

        return StreamBuilder<Duration>(
          stream: state.currentTime,
          initialData: Duration.zero,
          builder: (context, snapshot2) {
            final currentTime = snapshot2.data.inSeconds;

            return CircularProgressIndicator(
              value: duration > 0 ? currentTime / duration : null,
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                TWColors.purple.shade600,
              ),
              backgroundColor: TWColors.gray.shade300,
            );
          },
        );
      },
    );
  }

  Widget _buildActionButton(
    AudioPlayerBloc bloc,
    AudioPlayerLoaded state, {
    double size: 30,
  }) {
    return StreamBuilder<AP.AudioPlayerState>(
      stream: state.playerState,
      initialData: AP.AudioPlayerState.PAUSED,
      builder: (context, snapshot3) {
        final playerState = snapshot3.data;

        IconData iconData;
        Function onPressed;
        if (playerState == AP.AudioPlayerState.PLAYING) {
          iconData = Icons.pause;
          onPressed = () => bloc.add(Pause());
        } else if (playerState == AP.AudioPlayerState.PAUSED) {
          iconData = Icons.play_arrow;
          onPressed = () => bloc.add(Play());
        } else if (playerState == AP.AudioPlayerState.COMPLETED) {
          iconData = Icons.play_arrow;
          onPressed = () => bloc.add(Play());
        } else if (playerState == AP.AudioPlayerState.STOPPED) {
          iconData = Icons.stop;
          onPressed = () => bloc.add(Play());
        }

        return Material(
          color: Colors.transparent,
          child: IconButton(
            padding: new EdgeInsets.all(0.0),
            icon: Icon(
              iconData,
              color: TWColors.gray.shade600,
              size: size * 0.7,
            ),
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}
