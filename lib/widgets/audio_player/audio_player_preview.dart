import 'package:flutter/material.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

const fadeTill = 0.3;

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
    final colorAnimation = ColorTween(
      begin: Colors.white,
      end: TWColors.gray.shade200,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(fadeTill, 0.8, curve: Curves.linear),
      ),
    );

    return AnimatedBuilder(
      animation: colorAnimation,
      builder: (context, child) {
        return Container(
          height: 50,
          color: colorAnimation.value,
          padding: const EdgeInsets.only(left: 4, right: 16),
          child: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    final opacityAnimationMin = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, fadeTill - 0.001, curve: Curves.easeOut),
      ),
    );

    final opacityAnimationMax = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(fadeTill, 1.0, curve: Curves.easeOut),
      ),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.value < fadeTill) {
          return FadeTransition(
            opacity: opacityAnimationMin,
            child: _buildBodyMinimized(),
          );
        } else {
          return FadeTransition(
            opacity: opacityAnimationMax,
            child: _buildBodyMaximised(),
          );
        }
      },
    );
  }

  Widget _buildBodyMinimized() {
    final expandAudioPlayer = () => controller.animateBack(1.0,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    final expandButton = IconButton(
      padding: const EdgeInsets.all(0.0),
      icon: Icon(
        Icons.expand_less,
        color: TWColors.gray.shade700,
        size: 20,
      ),
      onPressed: expandAudioPlayer,
    );

    final episodeTitle = GestureDetector(
      onTap: expandAudioPlayer,
      child: Text(
        state.playingNow.episode.title,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, letterSpacing: 0.2),
      ),
    );

    final actionButton = SizedBox(
      height: 30,
      width: 30,
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
    final collapseAudioPlayer = () => controller.animateBack(0.0,
        duration: const Duration(milliseconds: 250), curve: Curves.ease);

    final collapseButton = IconButton(
      padding: const EdgeInsets.all(0.0),
      icon: Icon(
        Icons.expand_more,
        color: TWColors.gray.shade700,
        size: 20,
      ),
      onPressed: collapseAudioPlayer,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        collapseButton,
        Icon(
          Icons.share,
          color: TWColors.gray.shade700,
          size: 20,
        ),
      ],
    );
  }

  Widget _buildCircularProgressIndicator() {
    if (state.audioState.isLoading) {
      return CircularProgressIndicator(
        value: null,
        strokeWidth: 2.4,
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
          strokeWidth: 2.5,
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
