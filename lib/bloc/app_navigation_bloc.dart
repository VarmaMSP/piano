import 'package:flutter/material.dart';
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

class TabHistory {
  final List<Tab> s;

  TabHistory(this.s);

  TabHistory push(Tab tab) {
    return TabHistory(
      [if (listExists(s, tab)) ...listDelete(s, tab) else ...s, tab],
    );
  }

  TabHistory pop() {
    return TabHistory(
      [if (previousTab != null) ...s.sublist(0, s.length - 1) else ...s],
    );
  }

  /// Return current tab
  Tab get currentTab => s.last;

  /// Returns previous tab if exists
  Tab get previousTab => s.length > 1 ? s[s.length - 2] : null;
}

class AppNavigationBloc {
  /// States of tab navigators
  final Map<Tab, GlobalKey<NavigatorState>> _tabNavigatorKeys = {
    Tab.home: GlobalKey<NavigatorState>(),
    Tab.subscriptions: GlobalKey<NavigatorState>(),
  };

  /// Stream of history changes
  final BehaviorSubject<TabHistory> _tabHistorySubject =
      BehaviorSubject.seeded(TabHistory([Tab.home]));

  /// Switch tab
  void switchTab(Tab tab) async {
    final prev = await _tabHistorySubject.first;
    _tabHistorySubject.add(prev.push(tab));
  }

  /// Switched to previous tab if one exists
  void popTab() async {
    final prev = await _tabHistorySubject.first;
    _tabHistorySubject.add(prev.pop());
  }

  /// Navigate to screen
  void navigateTo(Screen screen) async {
    final currentTab = (await _tabHistorySubject.first).currentTab;
    final navigator = _tabNavigatorKeys[currentTab];

    await screen.when(
      podcast: (data) => navigator.currentState.pushNamed(
        '/podcast',
        arguments: {'urlParam': data.urlParam},
      ),
    );
  }

  Stream<TabHistory> get tabHistory => _tabHistorySubject.stream;

  Map<Tab, GlobalKey<NavigatorState>> get tabNavigatorKeys => _tabNavigatorKeys;

  Future<void> dispose() async {
    await _tabHistorySubject.close();
  }
}
