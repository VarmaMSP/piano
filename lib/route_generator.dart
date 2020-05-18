import 'package:flutter/material.dart';
import 'package:piano/screens/home/page.dart';
import 'package:piano/screens/podcast/page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, String> args = settings.arguments as Map<String, String>;

    switch (settings.name) {
      case '/podcast':
        return MaterialPageRoute<dynamic>(
            builder: (_) => PodcastPage(urlParam: args['urlParam']));

      default:
        return MaterialPageRoute<dynamic>(builder: (_) => const HomePage());
    }
  }
}
