import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

part 'app_navigation_bloc.g.dart';

@superEnum
enum _NavigateTo {
  @Data(fields: [DataField<String>('urlParam')])
  PodcastPage,
}

class AppNavigationBloc {
  /// Home tab navigator key
  final GlobalKey<NavigatorState> _homeTabNavigatorKey =
      GlobalKey<NavigatorState>();

  /// Sink to listen to navigation events
  final PublishSubject<NavigateTo> _navigateTo = PublishSubject<NavigateTo>();

  AppNavigationBloc() {
    /// Listen to NavigateTo commands from UI
    _handleNavigationEvents();
  }

  void _handleNavigationEvents() {
    _navigateTo.stream.distinct().listen((n) {
      n.when(podcastPage: (data) {
        _homeTabNavigatorKey.currentState
            .pushNamed('/podcast', arguments: {'urlParam': data.urlParam});
      });
    });
  }

  /// Navigate to page
  void Function(NavigateTo) get navigateTo => _navigateTo.add;

  /// Return home tabs navigator key
  GlobalKey<NavigatorState> get homeTabNavigatorKey => _homeTabNavigatorKey;

  Future<void> dispose() async {
    await _navigateTo.close();
  }
}
