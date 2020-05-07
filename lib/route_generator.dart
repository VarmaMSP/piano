import 'package:flutter/material.dart';
import 'package:piano/screens/home/page.dart';
import 'package:piano/screens/podcast/page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, String>;

    switch (settings.name) {
      case '/podcast':
        return MaterialPageRoute(
            builder: (_) => PodcastPage(urlParam: args['urlParam']));

      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
