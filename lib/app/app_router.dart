// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/screen/downloads_screen/download_screen.dart';

// Project imports:
import 'package:phenopod/screen/home_screen/home_screen.dart';
import 'package:phenopod/screen/library_screen/library_screen.dart';
import 'package:phenopod/screen/podcast_screen/podcast_screen.dart';
import 'package:phenopod/screen/subscriptions_screen/subscriptions_screen.dart';

Route<dynamic> Function(RouteSettings) makeGenerateRoute() {
  return (RouteSettings settings) {
    final args = settings.arguments as Map<dynamic, dynamic>;
    switch (settings.name) {
      case '/home':
        return PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => HomeScreen(),
        );

      case '/subscriptions':
        return PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => SubscriptionsScreen(),
        );

      case '/library':
        return PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => LibraryScreen(),
        );

      case '/downloads':
        return PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => DownloadsScreen(),
        );

      case '/podcast':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return PodcastScreen(
              urlParam: args['urlParam'],
              title: args['title'],
              author: args['author'],
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.9, 1.0, curve: Curves.linear),
                ),
              ),
              child: child,
            );
          },
        );

      default:
        return null;
    }
  };
}
