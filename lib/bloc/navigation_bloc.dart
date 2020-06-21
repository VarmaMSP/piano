import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

part 'navigation_bloc.g.dart';

@superEnum
enum _NavigateTo {
  @Data(fields: [DataField<String>('urlParam')])
  PodcastPage,
}

class NavigationBloc {
  /// App level navigator
  final GlobalKey<NavigatorState> navigatorState;

  /// Sink to listen to navigation events
  final PublishSubject<NavigateTo> _navigateTo = PublishSubject<NavigateTo>();

  NavigationBloc(this.navigatorState) {
    /// Listen to NavigateTo commands from UI
    _handleNavigationEvents();
  }

  void _handleNavigationEvents() {
    _navigateTo.stream.distinct().listen((n) {
      n.when(podcastPage: (data) {
        print('something is fucked up');
        navigatorState.currentState
            .pushNamed('/podcast', arguments: {'urlParam': data.urlParam});
      });
    });
  }

  /// Navigate to page
  void Function(NavigateTo) get navigateTo => _navigateTo.add;

  /// Return navigator key
  GlobalKey<NavigatorState> get navigatorKey => navigatorState;

  Future<void> dispose() async {
    await _navigateTo.close();
  }
}
