// Flutter imports:
import 'package:flutter/material.dart';

class SlideUpPageRoute extends MaterialPageRoute {
  final bool isInitialPageRoute;

  SlideUpPageRoute({
    @required WidgetBuilder builder,
    this.isInitialPageRoute = false,
  }) : super(builder: builder);

  /// Construct initial route
  SlideUpPageRoute.i({WidgetBuilder builder})
      : this(builder: builder, isInitialPageRoute: true);

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;

        final primaryClipAnimation = Tween<double>(
          begin: 0.0,
          end: size.height,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutExpo,
          ),
        );

        final secondaryTranslationAnimation = Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0, -0.05),
        ).animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: Curves.easeOut,
          ),
        );

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Container(
              alignment: Alignment.bottomLeft,
              child: ClipRect(
                child: SizedBox(
                  height: primaryClipAnimation.value,
                  child: OverflowBox(
                    alignment: Alignment.topLeft,
                    maxHeight: size.height,
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: AnimatedBuilder(
            animation: secondaryAnimation,
            child: child,
            builder: (context, child) {
              return FractionalTranslation(
                translation: secondaryTranslationAnimation.value,
                transformHitTests: false,
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
