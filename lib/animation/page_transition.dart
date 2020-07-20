// Flutter imports:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final enter = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0.15, 1.0, curve: Curves.easeOutExpo),
      ),
    );

    final enterSecondary = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.05),
    ).animate(
      CurvedAnimation(
        parent: secondaryAnimation,
        curve: Interval(0.15, 1.0, curve: Curves.easeOut),
      ),
    );

    return SlideTransition(
      position: enter,
      transformHitTests: false,
      child: SlideTransition(
        position: enterSecondary,
        transformHitTests: false,
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
  Duration get transitionDuration => Duration(milliseconds: 260);

  @override
  Duration get reverseTransitionDuration => Duration(milliseconds: 260);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final enter = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0.0, 1.0, curve: Curves.decelerate),
        reverseCurve: Interval(0.0, 1.0, curve: Curves.decelerate.flipped),
      ),
    );

    final enterSecondary = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.25, 0.0),
    ).animate(
      CurvedAnimation(
        parent: secondaryAnimation,
        curve: Interval(0.0, 1.0, curve: Curves.easeOut),
        reverseCurve: Interval(0.0, 1.0, curve: Curves.easeOut.flipped),
      ),
    );

    return SlideTransition(
      position: enter,
      transformHitTests: false,
      child: SlideTransition(
        position: enterSecondary,
        transformHitTests: false,
        child: ChangeNotifierProvider(
          create: (_) => RouteTransitionCompleteNotifier(animation),
          child: child,
        ),
      ),
    );
  }
}

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
