import 'package:flutter/material.dart';
import 'package:piano/blocs/audio_player/audio_player_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:audioplayers/audioplayers.dart' as AP;

class MiniAudioPlayer extends StatelessWidget {
  const MiniAudioPlayer({
    Key key,
    @required this.controller,
    @required this.state,
    @required this.onPlay,
    @required this.onPause,
  }) : super(key: key);

  final AnimationController controller;
  final AudioPlayerLoaded state;
  final Function onPlay;
  final Function onPause;

  @override
  Widget build(BuildContext context) {
    final sizeAnimation = Tween(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.linear),
      ),
    );

    final opacityAnimation = Tween(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: 1.0,
      sizeFactor: sizeAnimation,
      child: FadeTransition(
        opacity: opacityAnimation,
        child: GestureDetector(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.expand_less,
            color: TWColors.gray.shade700,
            size: 20,
          ),
          Container(width: 15.0),
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.animateBack(
                  1.0,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.ease,
                );
              },
              child: Text(
                state.episode.title,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          Container(width: 15.0),
          SizedBox(
            height: 30,
            width: 30,
            child: Stack(
              children: <Widget>[
                _buildCircularProgressIndicator(),
                _buildActionButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgressIndicator() {
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

  Widget _buildActionButton() {
    return StreamBuilder<AP.AudioPlayerState>(
      stream: state.playerState,
      initialData: AP.AudioPlayerState.PAUSED,
      builder: (context, snapshot3) {
        final playerState = snapshot3.data;

        IconData iconData;
        Function onPressed;
        if (playerState == AP.AudioPlayerState.PLAYING) {
          iconData = Icons.pause;
          onPressed = onPause;
        } else if (playerState == AP.AudioPlayerState.PAUSED) {
          iconData = Icons.play_arrow;
          onPressed = onPlay;
        } else if (playerState == AP.AudioPlayerState.COMPLETED) {
          iconData = Icons.play_arrow;
          onPressed = onPlay;
        } else if (playerState == AP.AudioPlayerState.STOPPED) {
          iconData = Icons.stop;
          onPressed = onPlay;
        }

        return Material(
          color: Colors.transparent,
          child: IconButton(
            padding: new EdgeInsets.all(0.0),
            icon: Icon(
              iconData,
              color: TWColors.gray.shade600,
              size: 18,
            ),
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}
