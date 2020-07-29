// Flutter imports:
import 'package:flutter/material.dart';

class PodcastScreenAnimation {
  final AnimationController controller;
  final Animation<double> appBarTitleOpacity;
  final Animation<double> podcastDetailsOpacity;

  PodcastScreenAnimation({
    @required this.controller,
  })  : appBarTitleOpacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.25, 1.0, curve: Curves.easeIn),
          ),
        ),
        podcastDetailsOpacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.1, 0.95, curve: Curves.easeOutCubic),
          ),
        );

  void animateTo(double shrinkOffset, double maxExtent, double minExtent) {
    controller.animateTo(
      shrinkOffset / (maxExtent - minExtent),
      duration: Duration.zero,
    );
  }

  bool get started => controller.value >= 0.2;

  bool get ended => 1.0 - controller.value <= 0.001;
}
