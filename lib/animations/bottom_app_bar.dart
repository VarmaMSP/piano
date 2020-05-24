import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class BottomAppBarAnimations {
  BottomAppBarAnimations({this.screenHeight, this.controller}) {
    controllerBeginWhenShow = _mapRange(
      bottomNavigationBarHeight,
      screenHeight,
      0.0,
      1.0,
      bottomAppBarHeight,
    );

    controllerBeginWhenHidden = 0.0;

    appBarHeight = Tween<double>(
      begin: bottomNavigationBarHeight,
      end: screenHeight,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    bottomNavigationBarSize = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          controllerBeginWhenShow,
          controllerBeginWhenShow + 0.3,
          curve: Curves.linear,
        ),
      ),
    );

    audioPlayerPreviewOpacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve:
            const Interval(0.0, hideAudioPlayerPreviewAt, curve: Curves.linear),
      ),
    );

    audioPlayerTopNavBarOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(showAudioPlayerTopNavBarFrom, 1.0,
            curve: Curves.linear),
      ),
    );

    playerBackgroundColor = ColorTween(
      begin: Colors.white,
      end: TWColors.gray.shade100,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(showAudioPlayerTopNavBarFrom, 1.0,
            curve: Curves.linear),
      ),
    );
  }

  static const double audioPlayerPreviewHeight = 50.0;
  static const double bottomNavigationBarHeight = 56.0;
  static const double bottomAppBarHeight =
      audioPlayerPreviewHeight + bottomNavigationBarHeight;
  static const double animationDuration = 350;
  static const double hideAudioPlayerPreviewAt = 0.35;
  static const double showAudioPlayerTopNavBarFrom = 0.4;

  final double screenHeight;
  final AnimationController controller;

  double controllerBeginWhenShow;
  double controllerBeginWhenHidden;
  Animation<double> appBarHeight;
  Animation<double> bottomNavigationBarSize;
  Animation<double> audioPlayerPreviewOpacity;
  Animation<double> audioPlayerTopNavBarOpacity;
  Animation<Color> playerBackgroundColor;

  bool _showAudioPlayer = false;
  double _dragDistance = 0.0;

  double get controllerBeginValue =>
      _showAudioPlayer ? controllerBeginWhenShow : controllerBeginWhenHidden;

  void Function(DragStartDetails) get verticalDragStartHandler =>
      _verticalDragStartHandler();

  void Function(DragUpdateDetails) get verticalDragUpdateHandler =>
      _verticalDragUpdateHandler();

  void Function(DragEndDetails) get verticalDragEndHandler =>
      _verticalDragEndHandler();

  void showAudioPlayerPreview() {
    _showAudioPlayer = true;
    controller.animateTo(
      controllerBeginValue,
      duration: Duration(milliseconds: 200),
      curve: Curves.linearToEaseOut,
    );
  }

  void hideAudioPlayerPreview() {
    _showAudioPlayer = false;
    controller.animateTo(
      controllerBeginValue,
      duration: Duration(milliseconds: 200),
      curve: Curves.linearToEaseOut,
    );
  }

  void expandBottomAppBar() {
    controller.animateTo(
      1.0,
      duration: Duration(milliseconds: 200),
      curve: Curves.decelerate,
    );
  }

  void collapseBottomAppBar() {
    controller.animateTo(
      controllerBeginValue,
      duration: Duration(milliseconds: 200),
      curve: Curves.decelerate,
    );
  }

  double _mapRange(double x1, double x2, double y1, double y2, double value) {
    if (value <= x1) {
      return y1;
    }
    if (value >= x2) {
      return y2;
    }
    return y1 + ((y2 - y1) / (x2 - x1)) * (value - x1);
  }

  void Function(DragStartDetails) _verticalDragStartHandler() {
    return (DragStartDetails details) {
      if (!_showAudioPlayer) {
        return;
      }

      // reset drag distance
      _dragDistance = 0.0;
      if (controller.value > controllerBeginValue) {
        _dragDistance = screenHeight - bottomAppBarHeight;
      }
    };
  }

  void Function(DragUpdateDetails) _verticalDragUpdateHandler() {
    return (DragUpdateDetails details) {
      if (!_showAudioPlayer) {
        return;
      }

      final maxDragDistance = screenHeight - bottomAppBarHeight;
      _dragDistance -= details.delta.dy;
      controller.animateTo(
        _mapRange(0, maxDragDistance, controllerBeginValue, 1.0, _dragDistance),
        duration: Duration.zero,
        curve: Curves.linear,
      );
    };
  }

  void Function(DragEndDetails) _verticalDragEndHandler() {
    return (DragEndDetails details) {
      if (!_showAudioPlayer) {
        return;
      }

      // collapse ot expand app bar
      if (controller.value <= 0.3) {
        details.primaryVelocity <= -1300
            ? expandBottomAppBar()
            : collapseBottomAppBar();
      } else {
        details.primaryVelocity >= 1300
            ? collapseBottomAppBar()
            : expandBottomAppBar();
      }
    };
  }
}
