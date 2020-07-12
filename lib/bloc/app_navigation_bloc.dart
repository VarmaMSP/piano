import 'package:flutter/material.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

part 'app_navigation_bloc.g.dart';

enum Tab {
  home,
  subscriptions,
}

@superEnum
enum _Screen {
  @Data(fields: [DataField<String>('urlParam')])
  Podcast,
}

class AppNavigationBloc {
  /// TabController and animations for bottom app bar
  final TabController playerTabController;
  final AnimationController playerAnimationController;

  /// Keys for individual tab navigators
  final Map<Tab, GlobalKey<NavigatorState>> _tabNavigatorKeys = {
    Tab.home: GlobalKey<NavigatorState>(),
    Tab.subscriptions: GlobalKey<NavigatorState>(),
  };

  /// Stream of history changes
  final BehaviorSubject<TabHistory> _tabHistorySubject =
      BehaviorSubject.seeded(TabHistory.init());

  /// BottomAppBarAnimation should be set by a widget inside material app
  BottomAppBarAnimation _bottomAppBarAnimation;

  set bottomAppBarAnimation(BottomAppBarAnimation x) {
    _bottomAppBarAnimation = x;
  }

  AppNavigationBloc({
    @required this.playerTabController,
    @required this.playerAnimationController,
  });

  /// Use this select a tab
  void pushTab(Tab tab) async {
    final prev = await _tabHistorySubject.first;
    if (prev.currentTab == tab) {
      _tabNavigatorKeys[tab].currentState.popUntil((route) => route.isFirst);
    } else {
      _tabHistorySubject.add(prev.push(tab));
    }
  }

  /// Use this to go to previous tab
  void popTab() async {
    final prev = await _tabHistorySubject.first;
    _tabHistorySubject.add(prev.pop());
  }

  /// Use this to select a screen
  void pushScreen(Screen screen) async {
    final currentTab = (await _tabHistorySubject.first).currentTab;
    final navigator = _tabNavigatorKeys[currentTab];

    // Close audio player if open
    if (_bottomAppBarAnimation != null &&
        _bottomAppBarAnimation.controller.value == 1.0) {
      _bottomAppBarAnimation.collapseBottomAppBar();
    }

    // Push new route
    await screen.when(
      podcast: (data) => navigator.currentState.pushNamed(
        '/podcast',
        arguments: {'urlParam': data.urlParam},
      ),
    );
  }

  /// Use this to go to previous screen
  void popScreen() async {
    await onWillPop();
  }

  /// Use this to veto back button press on app screen
  Future<bool> onWillPop() async {
    // Close audio player if open
    if (_bottomAppBarAnimation != null &&
        _bottomAppBarAnimation.controller.value == 1.0) {
      _bottomAppBarAnimation.collapseBottomAppBar();
      return false;
    }
    // Pop route if possible
    final tabHistory = await _tabHistorySubject.first;
    final isFirstRoute =
        !await tabNavigatorKeys[tabHistory.currentTab].currentState.maybePop();
    // Show previous tab if you cannot pop route from current tab
    if (isFirstRoute && tabHistory.previousTab != null) {
      popTab();
      return false;
    }
    // default to os
    return isFirstRoute;
  }

  Stream<TabHistory> get tabHistory => _tabHistorySubject.stream;

  BottomAppBarAnimation get bottomAppBarAnimation => _bottomAppBarAnimation;

  Map<Tab, GlobalKey<NavigatorState>> get tabNavigatorKeys => _tabNavigatorKeys;

  Future<void> dispose() async {
    await _tabHistorySubject.close();
  }
}

class TabHistory {
  final List<Tab> s;

  TabHistory(this.s);

  factory TabHistory.init() {
    return TabHistory([Tab.home]);
  }

  TabHistory push(Tab tab) {
    return TabHistory(
      [if (listExists(s, tab)) ...listDelete(s, tab) else ...s, tab],
    );
  }

  TabHistory pop() {
    return TabHistory(previousTab != null ? s.sublist(0, s.length - 1) : s);
  }

  /// Return current tab
  Tab get currentTab => s.last;

  /// Returns previous tab if exists
  Tab get previousTab => s.length > 1 ? s[s.length - 2] : null;
}
