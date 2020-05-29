import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phenopod/screens/home.dart';
import 'package:phenopod/screens/podcast.dart';

class RouteGenerator {
  static Route<dynamic> Function(RouteSettings) makeGenerateRoute(
    RouteObserver<PageRoute> routeObserver,
  ) {
    return (RouteSettings settings) {
      final args = settings.arguments as Map<String, String>;

      switch (settings.name) {
        case '/podcast':
          return PageTransition(
            child: PodcastScreen(urlParam: args['urlParam']),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 150),
            curve: Curves.easeInOutExpo,
          );

        default:
          return PageTransition(
            child: HomeScreen(routeObserver: routeObserver),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 150),
            curve: Curves.easeInOutExpo,
          );
      }
    };
  }
}
