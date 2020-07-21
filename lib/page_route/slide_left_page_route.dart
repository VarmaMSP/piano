// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'route_transition_complete_notifier.dart';

class SlideLeftPageRoute extends MaterialPageRoute {
  SlideLeftPageRoute({
    @required WidgetBuilder builder,
  }) : super(builder: builder);

  @override
  Duration get transitionDuration => Duration(milliseconds: 260);

  @override
  Duration get reverseTransitionDuration => Duration(milliseconds: 300);

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
        curve: Curves.decelerate,
        reverseCurve: Curves.decelerate.flipped,
      ),
    );

    final enterSecondary = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.25, 0.0),
    ).animate(
      CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeOut.flipped,
      ),
    );

    return SlideTransition(
      position: enter,
      transformHitTests: false,
      child: SlideTransition(
        position: enterSecondary,
        transformHitTests: false,
        child: Provider(
          create: (_) => RouteTransitionCompleteNotifier(animation),
          dispose: (_, value) => value.dispose(),
          child: child,
        ),
      ),
    );
  }
}
