// Flutter imports:
import 'package:flutter/material.dart';

class RouteTransitionCompleteNotifier extends ValueNotifier<bool> {
  RouteTransitionCompleteNotifier(
    Animation<double> pageAnimation,
  ) : super(false) {
    pageAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        value = true;
      }
    });
  }
}
