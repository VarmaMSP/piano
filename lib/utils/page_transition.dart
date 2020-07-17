// Flutter imports:
import 'package:flutter/material.dart';

class ParallaxRoute extends MaterialPageRoute {
  ParallaxRoute({
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
    return child;
  }
}

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
        CurvedAnimation(parent: animation, curve: Curves.easeOutExpo),
      ),
      child: child,
    );
  }
}

class ZoomPageRoute extends MaterialPageRoute {
  ZoomPageRoute({
    @required WidgetBuilder builder,
  }) : super(builder: builder);

  @override
  Color get barrierColor => Colors.white;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ZoomPageTransitionsBuilder().buildTransitions(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
