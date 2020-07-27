// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:when_expression/when_expression.dart';

// Project imports:
import 'package:phenopod/page_route/notifiers.dart';

enum PagePopInMode {
  instant,
  showBeforeComplete,
  showOnComplete,
  showAfterDelay,
}

Widget buildPagePopIn(
  Widget page,
  Animation<double> animation,
  PagePopInMode popInMode,
) {
  return when<PagePopInMode, Widget>({
    (p) => p == PagePopInMode.instant: (_) => page,
    (p) => p == PagePopInMode.showBeforeComplete: (_) =>
        _showBeforeComplete(page, animation),
    (p) => p == PagePopInMode.showOnComplete: (_) =>
        _buildShowOnComplete(page, animation),
    (p) => p == PagePopInMode.showAfterDelay: (_) =>
        _buildShowAfterDelay(page, animation),
  })(popInMode);
}

Widget _showBeforeComplete(Widget child, Animation<double> animation) {
  return ValueListenableProvider<bool>(
    create: (_) => RouteTransitionProgressCompleteNotifier(
      progress: 0.2,
      animation: animation,
    ),
    builder: (context, child) => child,
    child: Consumer<bool>(
      child: child,
      builder: (context, progressComplete, child) {
        return Stack(
          children: [
            Container(color: Colors.white),
            Offstage(
              offstage: !progressComplete,
              child: child,
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildShowOnComplete(Widget child, Animation<double> animation) {
  return ValueListenableProvider<bool>(
    create: (_) => RouteTransitionCompleteNotifier(animation: animation),
    builder: (context, child) => child,
    child: Consumer<bool>(
      child: child,
      builder: (context, transitionComplete, child) {
        return Stack(
          children: [
            Container(color: Colors.white),
            Offstage(
              offstage: !transitionComplete,
              child: child,
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildShowAfterDelay(Widget child, Animation<double> animation) {
  return ValueListenableProvider<bool>(
    create: (_) => RouteTransitionCompleteNotifier(animation: animation),
    builder: (context, child) => child,
    child: Consumer<bool>(
      child: child,
      builder: (context, routeTransitionComplete, child) {
        return FutureBuilder<bool>(
          future: Future.delayed(Duration(milliseconds: 40), () => true),
          builder: (context, snapshot) {
            return Stack(
              children: [
                Container(color: Colors.white),
                if (routeTransitionComplete)
                  Offstage(
                    offstage: !snapshot.hasData,
                    child: child,
                  ),
              ],
            );
          },
        );
      },
    ),
  );
}
