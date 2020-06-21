import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phenopod/screen/home_screen/home_screen.dart';
import 'package:phenopod/screen/podcast_screen/podcast_screen.dart';
import 'package:phenopod/screen/search_screen/search_screen.dart';

Route<dynamic> Function(RouteSettings) makeGenerateRoute(
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
          curve: Curves.easeIn,
        );

      case '/search':
        return PageTransition(
          child: SearchScreen(),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInExpo,
        );

      default:
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOutExpo,
        );
    }
  };
}