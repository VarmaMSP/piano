import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';

class AudioPlayerPreview extends StatelessWidget {
  const AudioPlayerPreview({
    Key key,
    @required this.animations,
    @required this.state,
    @required this.onPlay,
    @required this.onPause,
  }) : super(key: key);

  final BottomAppBarAnimations animations;
  final AudioPlayerActive state;
  final Function onPlay;
  final Function onPause;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animations.playerBackgroundColor,
      builder: (context, child) {
        return Container(
          height: 50,
          color: animations.playerBackgroundColor.value,
          padding: const EdgeInsets.only(left: 4, right: 16),
          child: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    return AnimatedBuilder(
      animation: animations.controller,
      builder: (context, child) {
        log('${animations.controller.value} ${animations.controllerBeginValue}');
        if (animations.controller.value < 0.4) {
          return FadeTransition(
            opacity: animations.audioPlayerPreviewOpacity,
            child: _buildBodyMinimized(),
          );
        } else {
          return FadeTransition(
            opacity: animations.audioPlayerTopNavBarOpacity,
            child: _buildBodyMaximised(),
          );
        }
      },
    );
  }

  Widget _buildBodyMinimized() {
    final expandButton = IconButton(
      padding: const EdgeInsets.all(0.0),
      icon: Icon(
        Icons.expand_less,
        color: TWColors.gray.shade700,
        size: 20,
      ),
      onPressed: animations.expandBottomAppBar,
    );

    final episodeTitle = GestureDetector(
      onTap: animations.expandBottomAppBar,
      child: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              state.playingNow.episode.title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, letterSpacing: 0.2),
            ),
          ],
        ),
      ),
    );

    final actionButton = SizedBox(
      height: 32,
      width: 32,
      child: Stack(
        children: <Widget>[
          _buildCircularProgressIndicator(),
          _buildActionButton(),
        ],
      ),
    );

    return Row(
      children: <Widget>[
        expandButton,
        Expanded(child: episodeTitle),
        Container(width: 15.0),
        actionButton,
      ],
    );
  }

  Widget _buildBodyMaximised() {
    final collapseButton = IconButton(
      padding: const EdgeInsets.all(0.0),
      icon: Icon(
        Icons.expand_more,
        color: TWColors.gray.shade700,
        size: 24,
      ),
      onPressed: animations.collapseBottomAppBar,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        collapseButton,
      ],
    );
  }

  Widget _buildCircularProgressIndicator() {
    if (state.audioState.isLoading) {
      return CircularProgressIndicator(
        value: null,
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(
          TWColors.purple.shade600,
        ),
        backgroundColor: TWColors.gray.shade300,
      );
    }

    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)),
      builder: (context, snapshot) {
        final duration = state.audioState.duration;
        final currentTime = state.audioState.currentTime;

        return CircularProgressIndicator(
          value: currentTime / duration,
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            TWColors.purple.shade600,
          ),
          backgroundColor: TWColors.gray.shade300,
        );
      },
    );
  }

  Widget _buildActionButton() {
    IconData iconData;
    void Function() onPressed;
    if (state.audioState.isPlaying) {
      iconData = Icons.pause;
      onPressed = () => onPause();
    } else if (state.audioState.isPaused) {
      iconData = Icons.play_arrow;
      onPressed = () => onPlay();
    } else {
      iconData = Icons.play_arrow;
      onPressed = () {};
    }

    return Material(
      color: Colors.transparent,
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        icon: Icon(
          iconData,
          color: TWColors.gray.shade600,
          size: 20,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
