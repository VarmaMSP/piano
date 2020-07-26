// Flutter imports:
import 'package:flutter/material.dart';

class RouteTransitionCompleteNotifier extends ValueNotifier<bool> {
  RouteTransitionCompleteNotifier(
    Animation<double> animationController,
  ) : super(false) {
    animationController.addStatusListener(
      (status) {
        switch (status) {
          case AnimationStatus.dismissed:
          case AnimationStatus.forward:
          case AnimationStatus.reverse:
            value = false;
            break;
          case AnimationStatus.completed:
            value = true;
            break;
        }
      },
    );
  }
}
