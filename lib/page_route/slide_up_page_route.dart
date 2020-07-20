// Flutter imports:
import 'package:flutter/material.dart';

class SlideUpPageRoute extends MaterialPageRoute {
  SlideUpPageRoute({
    @required WidgetBuilder builder,
  }) : super(builder: builder);

  @override
  Duration get transitionDuration => Duration(milliseconds: 260);

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
      CurvedAnimation(parent: animation, curve: Curves.easeOutExpo),
    );

    final enterSecondary = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.05),
    ).animate(
      CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeOut),
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
