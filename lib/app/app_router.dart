// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:phenopod/page_route/slide_left_page_route.dart';
import 'package:phenopod/screens/downloads_screen/download_screen.dart';
import 'package:phenopod/screens/episode_screen/episode_screen.dart';
import 'package:phenopod/screens/home_screen/home_screen.dart';
import 'package:phenopod/screens/library_screen/library_screen.dart';
import 'package:phenopod/screens/podcast_screen/podcast_screen.dart';
import 'package:phenopod/screens/subscriptions_screen/subscriptions_screen.dart';

Route<dynamic> Function(RouteSettings) makeGenerateRoute() {
  return (RouteSettings settings) {
    final args = settings.arguments as Map<dynamic, dynamic>;

    switch (settings.name) {
      case '/home':
        return SlideLeftPageRoute.i(builder: (_) => HomeScreen());
      case '/subscriptions':
        return SlideLeftPageRoute.i(builder: (_) => SubscriptionsScreen());
      case '/library':
        return SlideLeftPageRoute.i(builder: (_) => LibraryScreen());
      case '/downloads':
        return SlideLeftPageRoute.c(builder: (_) => DownloadsScreen());
      case '/podcast':
        return SlideLeftPageRoute.d(
          builder: (_) => PodcastScreen(
            urlParam: args['urlParam'],
            placeholder: args['placeholder'],
          ),
        );
      case '/episode':
        return SlideLeftPageRoute.c(
          builder: (_) => EpisodeScreen(urlParam: args['urlParam']),
        );
      default:
        return null;
    }
  };
}
