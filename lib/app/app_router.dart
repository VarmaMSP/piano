import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/screen/home_screen/home_screen.dart';
import 'package:phenopod/screen/podcast_screen/podcast_screen.dart';
import 'package:phenopod/screen/subscriptions_screen/subscriptions_screen.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';

Route<dynamic> Function(RouteSettings) makeGenerateRoute() {
  return (RouteSettings settings) {
    final args = settings.arguments as Map<String, String>;
    switch (settings.name) {
      case '/home':
        return PageTransition(
          type: PageTransitionType.slideParallaxLeft,
          child: HomeScreen(),
        );

      case '/subscriptions':
        return PageTransition(
          type: PageTransitionType.slideParallaxLeft,
          child: SubscriptionsScreen(),
        );

      case '/podcast':
        return PageTransition(
          type: PageTransitionType.slideParallaxLeft,
          child: PodcastScreen(urlParam: args['urlParam']),
        );

      default:
        return null;
    }
  };
}
