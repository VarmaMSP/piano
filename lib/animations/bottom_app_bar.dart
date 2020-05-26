import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'utils.dart';

class BottomAppBarAnimations {
  BottomAppBarAnimations({
    @required this.controller,
    @required this.screenHeight,
    @required this.controllerBeginWhenShow,
  })  : appBarHeight = Tween<double>(
          begin: bottomNavigationBarHeight,
          end: screenHeight,
        ).animate(controller),
        //
        bottomNavigationBarSize = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
                controllerBeginWhenShow, controllerBeginWhenShow + 0.3,
                curve: Curves.linear),
          ),
        ),
        //
        audioPlayerPreviewOpacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, hideAudioPlayerPreviewAt,
                curve: Curves.linear),
          ),
        ),
        //
        audioPlayerTopNavBarOpacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(showAudioPlayerTopNavBarFrom, 1.0,
                curve: Curves.linear),
          ),
        ),
        //
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

  factory BottomAppBarAnimations.New(
    BuildContext context,
    AnimationController controller,
  ) {
    final screenHeight = getScreenHeight(context);
    final controllerBeginWhenShow = mapRange(
      bottomNavigationBarHeight,
      screenHeight,
      0.0,
      1.0,
      bottomAppBarHeight,
    );

    return BottomAppBarAnimations(
      controller: controller,
      screenHeight: screenHeight,
      controllerBeginWhenShow: controllerBeginWhenShow,
    );
  }

  static const double audioPlayerPreviewHeight = 50.0;
  static const double bottomNavigationBarHeight = 56.0;
  static const double bottomAppBarHeight = 106.0;
  static const double hideAudioPlayerPreviewAt = 0.35;
  static const double showAudioPlayerTopNavBarFrom = 0.4;

  final AnimationController controller;
  final double screenHeight;
  final double controllerBeginWhenShow;
  final Animation<double> appBarHeight;
  final Animation<double> bottomNavigationBarSize;
  final Animation<double> audioPlayerPreviewOpacity;
  final Animation<double> audioPlayerTopNavBarOpacity;
  final Animation<Color> playerBackgroundColor;

  bool _showAudioPlayer = false;
  double _dragDistance = 0.0;

  double get controllerBeginValue =>
      _showAudioPlayer ? controllerBeginWhenShow : 0.0;

  void Function(DragStartDetails) get verticalDragStartHandler =>
      _verticalDragStartHandler();

  void Function(DragUpdateDetails) get verticalDragUpdateHandler =>
      _verticalDragUpdateHandler();

  void Function(DragEndDetails) get verticalDragEndHandler =>
      _verticalDragEndHandler();

  void showAudioPlayerPreview() {
    if (!_showAudioPlayer) {
      _showAudioPlayer = true;
      controller.animateTo(
        controllerBeginValue,
        duration: Duration(milliseconds: 150),
        curve: Curves.linear,
      );
    }
  }

  void hideAudioPlayerPreview() {
    if (_showAudioPlayer) {
      _showAudioPlayer = false;
      controller.animateTo(
        controllerBeginValue,
        duration: Duration(milliseconds: 150),
        curve: Curves.linear,
      );
    }
  }

  void expandBottomAppBar() {
    controller.animateTo(
      1.0,
      duration: Duration(milliseconds: 400),
      curve: Curves.linearToEaseOut,
    );
  }

  void collapseBottomAppBar() {
    controller.animateTo(
      controllerBeginValue,
      duration: Duration(milliseconds: 400),
      curve: Curves.linearToEaseOut,
    );
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
        mapRange(0, maxDragDistance, controllerBeginValue, 1.0, _dragDistance),
        duration: Duration.zero,
      );
    };
  }

  void Function(DragEndDetails) _verticalDragEndHandler() {
    return (DragEndDetails details) {
      if (!_showAudioPlayer) {
        return;
      }

      // collapse ot expand app bar
      if (controller.value <= 0.45) {
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
