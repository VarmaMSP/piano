// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:phenopod/page_route/slide_left_page_route.dart';
import 'package:phenopod/screen/downloads_screen/download_screen.dart';
import 'package:phenopod/screen/home_screen/home_screen.dart';
import 'package:phenopod/screen/library_screen/library_screen.dart';
import 'package:phenopod/screen/subscriptions_screen/subscriptions_screen.dart';

Route<dynamic> Function(RouteSettings) makeGenerateRoute() {
  return (RouteSettings settings) {
    final args = settings.arguments as Map<dynamic, dynamic>;

    switch (settings.name) {
      case '/home':
        return SlideLeftPageRoute(builder: (_) => HomeScreen());
      case '/subscriptions':
        return SlideLeftPageRoute(builder: (_) => SubscriptionsScreen());
      case '/library':
        return SlideLeftPageRoute(builder: (_) => LibraryScreen());
      case '/downloads':
        return SlideLeftPageRoute(builder: (_) => DownloadsScreen());
      case '/podcast':
        return SlideLeftPageRoute(builder: (_) => args['screen']);
      default:
        return null;
    }
  };
}
