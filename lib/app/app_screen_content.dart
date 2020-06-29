import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Tab;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/hook/use_snack_bar.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';

class AppScreenContent extends HookWidget {
  final TabController audioPlayerTabController;
  final BottomAppBarAnimation bottomAppBarAnimation;

  const AppScreenContent({
    Key key,
    this.audioPlayerTabController,
    this.bottomAppBarAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useSnackBar();

    final appNavigationBloc = Provider.of<AppNavigationBloc>(context);

    return StreamBuilder<TabHistory>(
      initialData: TabHistory.init(),
      stream: appNavigationBloc.tabHistory,
      builder: (context, snapshot) {
        final tabNavigatorKeys = appNavigationBloc.tabNavigatorKeys;

        return SafeArea(
          child: Stack(
            children: <Widget>[
              _buildTab(
                key: tabNavigatorKeys[Tab.home],
                initialRoute: '/home',
                offstage: snapshot.data.currentTab != Tab.home,
              ),
              _buildTab(
                key: tabNavigatorKeys[Tab.subscriptions],
                initialRoute: '/subscriptions',
                offstage: snapshot.data.currentTab != Tab.subscriptions,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab({
    GlobalKey<NavigatorState> key,
    String initialRoute,
    bool offstage,
  }) {
    return Offstage(
      offstage: offstage,
      child: Container(
        color: Colors.white,
        child: Navigator(
          key: key,
          initialRoute: initialRoute,
          onGenerateRoute: makeGenerateRoute(),
        ),
      ),
    );
  }
}
