// Flutter imports:
import 'package:flutter/material.dart';

class RouteTransitionCompleteNotifier extends ValueNotifier<bool> {
  final Animation<double> animation;

  RouteTransitionCompleteNotifier({@required this.animation}) : super(false) {
    animation.addStatusListener(_statusListener);
  }

  @override
  void dispose() {
    animation.removeStatusListener(_statusListener);
    super.dispose();
  }

  void _statusListener(AnimationStatus status) {
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
  }
}

class RouteTransitionProgressCompleteNotifier extends ValueNotifier<bool> {
  final double progress;
  final Animation<double> animation;

  AnimationStatus _status;

  RouteTransitionProgressCompleteNotifier({
    @required this.progress,
    @required this.animation,
  }) : super(false) {
    animation.addListener(_listener);
    animation.addStatusListener(_statusListener);
  }

  @override
  void dispose() {
    animation.removeStatusListener(_statusListener);
    animation.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    final animationValue = animation.value;
    print('${animationValue} - ${_status} - ${value}');
    if (_status == AnimationStatus.forward && animationValue >= progress) {
      value = true;
      return;
    }
    if (_status == AnimationStatus.reverse && animationValue < progress) {
      value = false;
      return;
    }
  }

  void _statusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.forward:
        _status = AnimationStatus.forward;
        break;
      case AnimationStatus.reverse:
        _status = AnimationStatus.reverse;
        break;
      case AnimationStatus.completed:
        break;
    }
  }
}
