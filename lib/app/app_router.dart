import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/screen/home_screen/home_screen.dart';
import 'package:phenopod/screen/podcast_screen/podcast_screen.dart';
import 'package:phenopod/screen/subscriptions_screen/subscriptions_screen.dart';

Route<dynamic> Function(RouteSettings) makeGenerateRoute() {
  return (RouteSettings settings) {
    final args = settings.arguments as Map<String, String>;
    switch (settings.name) {
      case '/home':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        );

      case '/subscriptions':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SubscriptionsScreen(),
        );

      case '/podcast':
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              PodcastScreen(urlParam: args['urlParam']),
        );

      default:
        return null;
    }
  };
}
