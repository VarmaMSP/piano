// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:phenopod/page_route/helpers.dart';

class SlideUpPageRoute extends MaterialPageRoute {
  final PagePopInMode pagePopInMode;

  SlideUpPageRoute({
    @required WidgetBuilder builder,
    @required this.pagePopInMode,
  }) : super(builder: builder);

  /// instant pop in
  SlideUpPageRoute.i({WidgetBuilder builder})
      : this(builder: builder, pagePopInMode: PagePopInMode.instant);

  /// show before complete
  SlideUpPageRoute.b({WidgetBuilder builder})
      : this(builder: builder, pagePopInMode: PagePopInMode.showBeforeComplete);

  /// show before complete
  SlideUpPageRoute.c({WidgetBuilder builder})
      : this(builder: builder, pagePopInMode: PagePopInMode.showOnComplete);

  /// show aftter delay
  SlideUpPageRoute.d({WidgetBuilder builder})
      : this(builder: builder, pagePopInMode: PagePopInMode.showAfterDelay);

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
            child: buildPagePopIn(child, animation, pagePopInMode),
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
