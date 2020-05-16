import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/audio_player/audio_player_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:audioplayers/audioplayers.dart' as AP;

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({Key key, this.controller}) : super(key: key);

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      bloc: audioPlayerBloc,
      builder: (context, state) {
        if (state is AudioPlayerInitial) {
          return _buildEmptyPlayer();
        }

        return _buildPlayer(context, state, audioPlayerBloc);
      },
    );
  }

  Widget _buildEmptyPlayer() {
    return Container(
      constraints: BoxConstraints.expand(height: 56),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: TWColors.gray.shade300, blurRadius: 2.0)],
      ),
    );
  }

  Widget _buildPlayer(
    BuildContext context,
    AudioPlayerLoaded state,
    AudioPlayerBloc bloc,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    final animation = Tween(begin: 106.0 / screenHeight, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.ease),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: TWColors.gray.shade300, blurRadius: 2.0)],
      ),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return SizeTransition(
            axis: Axis.vertical,
            axisAlignment: -1.0,
            sizeFactor: animation,
            child: Container(
              height: screenHeight,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildMiniPlayer(state, bloc),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMiniPlayer(
    AudioPlayerLoaded state,
    AudioPlayerBloc bloc,
  ) {
    final animation = Tween(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.ease),
      ),
    );

    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.expand_less,
                color: TWColors.gray.shade800,
                size: 22,
              ),
              onPressed: () {
                controller.forward(from: 0.0);
              },
            ),
            Container(width: 10.0),
            Expanded(
              child: Text(
                state.episode.title,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            SizedBox(
              height: 31,
              width: 31,
              child: Stack(
                children: <Widget>[
                  _buildCircularProgressIndicator(state),
                  _buildActionButton(state, bloc),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularProgressIndicator(
    AudioPlayerLoaded state,
  ) {
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
    AudioPlayerLoaded state,
    AudioPlayerBloc bloc, {
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
