import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart' as n;
import 'package:phenopod/widgets/show_snack_bar/show_snack_bar.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';

class AppScreenContent extends StatelessWidget {
  final TabController audioPlayerTabController;
  final BottomAppBarAnimation bottomAppBarAnimation;

  const AppScreenContent({
    Key key,
    this.audioPlayerTabController,
    this.bottomAppBarAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appNavigationBloc = Provider.of<n.AppNavigationBloc>(context);

    return StreamBuilder<n.TabHistory>(
      initialData: n.TabHistory.init(),
      stream: appNavigationBloc.tabHistory,
      builder: (context, snapshot) {
        final tabNavigatorKeys = appNavigationBloc.tabNavigatorKeys;

        return SafeArea(
          child: Stack(
            children: <Widget>[
              _buildTab(
                key: tabNavigatorKeys[n.Tab.home],
                initialRoute: '/home',
                offstage: snapshot.data.currentTab != n.Tab.home,
              ),
              _buildTab(
                key: tabNavigatorKeys[n.Tab.subscriptions],
                initialRoute: '/subscriptions',
                offstage: snapshot.data.currentTab != n.Tab.subscriptions,
              ),
              ShowSnackBar(),
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
