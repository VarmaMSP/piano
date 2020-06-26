import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phenopod/screen/home_screen/home_screen.dart';
import 'package:phenopod/screen/podcast_screen/podcast_screen.dart';
import 'package:phenopod/screen/subscriptions_screen/subscriptions_screen.dart';

Route<dynamic> Function(RouteSettings) makeGenerateRoute() {
  return (RouteSettings settings) {
    final args = settings.arguments as Map<String, String>;
    switch (settings.name) {
      case '/home':
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOutExpo,
        );

      case '/subscriptions':
        return PageTransition(
          child: SubscriptionsScreen(),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeIn,
        );

      case '/podcast':
        return PageTransition(
          child: PodcastScreen(urlParam: args['urlParam']),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeIn,
        );

      default:
        return null;
    }
  };
}
