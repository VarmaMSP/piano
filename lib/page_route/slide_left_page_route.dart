// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'helpers.dart';

class SlideLeftPageRoute extends MaterialPageRoute {
  final PagePopInMode pagePopInMode;

  SlideLeftPageRoute({
    @required WidgetBuilder builder,
    @required this.pagePopInMode,
  }) : super(builder: builder);

  /// instant pop in
  SlideLeftPageRoute.i({WidgetBuilder builder})
      : this(builder: builder, pagePopInMode: PagePopInMode.instant);

  /// show before complete
  SlideLeftPageRoute.b({WidgetBuilder builder})
      : this(builder: builder, pagePopInMode: PagePopInMode.showBeforeComplete);

  /// show on complete
  SlideLeftPageRoute.c({WidgetBuilder builder})
      : this(builder: builder, pagePopInMode: PagePopInMode.showOnComplete);

  /// show after delay
  SlideLeftPageRoute.d({WidgetBuilder builder})
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
          end: size.width,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutExpo,
            reverseCurve: Curves.easeOutCubic.flipped,
          ),
        );

        final secondaryTranslationAnimation = Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.25, 0.0),
        ).animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: Curves.easeOutCirc,
            reverseCurve: Curves.easeOutCirc.flipped,
          ),
        );

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Container(
              alignment: Alignment.centerRight,
              child: ClipRect(
                child: SizedBox(
                  width: primaryClipAnimation.value,
                  child: OverflowBox(
                    alignment: Alignment.centerLeft,
                    maxWidth: size.width,
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
