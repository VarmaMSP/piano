// Flutter imports:
import 'package:flutter/material.dart';

class EpisodeScreenAnimation {
  final AnimationController controller;
  final Animation<double> appBarTitleOpacity;

  EpisodeScreenAnimation({
    @required this.controller,
  }) : appBarTitleOpacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.1, 0.35, curve: Curves.easeIn),
          ),
        );

  void animateTo(double scrollPosition, double maxScrollExtent) {
    controller.animateTo(
      scrollPosition / maxScrollExtent,
      duration: Duration.zero,
    );
  }
}
