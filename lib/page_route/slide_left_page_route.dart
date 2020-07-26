// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'common.dart';

class SlideLeftPageRoute extends MaterialPageRoute {
  final bool isInitialPageRoute;

  SlideLeftPageRoute({
    @required WidgetBuilder builder,
    this.isInitialPageRoute = false,
  }) : super(builder: builder);

  /// Construct initial route
  SlideLeftPageRoute.i({WidgetBuilder builder})
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
          end: size.width,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutExpo,
            reverseCurve: Curves.easeOutExpo.flipped,
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
            child: isInitialPageRoute ? child : _buildWidget(child, animation),
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

  Widget _buildWidget(Widget child, Animation<double> animation) {
    return ValueListenableProvider<bool>(
      create: (_) => RouteTransitionCompleteNotifier(animation),
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
}
