import 'package:flutter/material.dart';
import 'package:phenopod/screens/home.dart';
import 'package:phenopod/screens/podcast/page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, String>;

    switch (settings.name) {
      case '/podcast':
        return MaterialPageRoute<dynamic>(
            builder: (_) => PodcastPage(urlParam: args['urlParam']));

      default:
        return MaterialPageRoute<dynamic>(builder: (_) => HomeScreen());
    }
  }
}
