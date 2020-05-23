import 'package:flutter/material.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

const fadeTill = 0.3;

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({
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
          constraints: const BoxConstraints.expand(height: 350),
          color: colorAnimation.value,
        );
      },
    );
  }
}
