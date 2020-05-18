import 'package:flutter/material.dart';
import 'package:phenopod/blocs/audio_player/main.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AudioPlayerPreview extends StatelessWidget {
  const AudioPlayerPreview({
    Key key,
    @required this.controller,
    @required this.state,
    @required this.onPlay,
    @required this.onPause,
  }) : super(key: key);

  final AnimationController controller;
  final AudioPlayerActive state;
  final Function onPlay;
  final Function onPause;

  @override
  Widget build(BuildContext context) {
    final Animation<double> sizeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.9, 1.0, curve: Curves.linear),
      ),
    );

    final Animation<double> opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
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
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.ease,
                );
              },
              child: Text(
                state.episode.title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
    final int duration = state.duration.inSeconds;
    final int currentTime = state.currentTime.inSeconds;
    final String playbackState = state.playbackState;

    return CircularProgressIndicator(
      value: playbackState == 'LOADING' ? null : currentTime / duration,
      strokeWidth: 2.25,
      valueColor: AlwaysStoppedAnimation<Color>(
        TWColors.purple.shade600,
      ),
      backgroundColor: TWColors.gray.shade300,
    );
  }

  Widget _buildActionButton() {
    final String playbackState = state.playbackState;

    IconData iconData;
    void Function() onPressed;
    if (playbackState == 'PLAYING') {
      iconData = Icons.pause;
      onPressed = () => onPause();
    } else if (playbackState == 'PAUSED' || playbackState == 'BUFFERING') {
      iconData = Icons.play_arrow;
      onPressed = () => onPlay();
    } else {
      iconData = Icons.play_arrow;
      onPressed = () => onPlay();
    }

    return Material(
      color: Colors.transparent,
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        icon: Icon(
          iconData,
          color: TWColors.gray.shade600,
          size: 18,
        ),
        onPressed: onPressed,
      ),
    );
  }
}