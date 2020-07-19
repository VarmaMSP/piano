// Flutter imports:
import 'package:flutter/material.dart';

class SlideUpPageRoute extends MaterialPageRoute {
  SlideUpPageRoute({
    @required WidgetBuilder builder,
  }) : super(builder: builder);

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(0.15, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0, -0.2),
        ).animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: Interval(0.15, 1.0, curve: Curves.linear),
          ),
        ),
        child: child,
      ),
    );
  }
}

class SlideLeftPageRoute extends MaterialPageRoute {
  SlideLeftPageRoute({
    @required WidgetBuilder builder,
  }) : super(builder: builder);

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(0.25, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.15, 0.0),
        ).animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: Interval(0.25, 1.0, curve: Curves.linear),
          ),
        ),
        child: child,
      ),
    );
  }
}
