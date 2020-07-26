// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/hook/use_snack_bar.dart';
import 'package:phenopod/model/main.dart';
import 'app_router.dart';

class AppScreenContent extends HookWidget {
  const AppScreenContent({Key key}) : super(key: key);

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
                key: tabNavigatorKeys[AppTab.homeTab],
                initialRoute: '/home',
                offstage: snapshot.data.currentTab != AppTab.homeTab,
              ),
              _buildTab(
                key: tabNavigatorKeys[AppTab.subscriptionsTab],
                initialRoute: '/subscriptions',
                offstage: snapshot.data.currentTab != AppTab.subscriptionsTab,
              ),
              _buildTab(
                key: tabNavigatorKeys[AppTab.libraryTab],
                initialRoute: '/library',
                offstage: snapshot.data.currentTab != AppTab.libraryTab,
              )
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
    return RepaintBoundary(
      child: Offstage(
        offstage: offstage,
        child: Container(
          color: Colors.white,
          child: Navigator(
            key: key,
            initialRoute: initialRoute,
            onGenerateRoute: makeGenerateRoute(),
          ),
        ),
      ),
    );
  }
}
