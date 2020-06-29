import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart' as t;
import 'package:provider/provider.dart';
import 'package:phenopod/widgets/bottom_app_bar/main.dart' as b;

class AppScreenBottomView extends StatelessWidget {
  final TabController audioPlayerTabController;
  final BottomAppBarAnimation bottomAppBarAnimation;

  const AppScreenBottomView({
    Key key,
    this.audioPlayerTabController,
    this.bottomAppBarAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appNavigationBloc = Provider.of<t.AppNavigationBloc>(context);

    return StreamBuilder<t.TabHistory>(
      initialData: t.TabHistory.init(),
      stream: appNavigationBloc.tabHistory,
      builder: (context, snapshot) {
        return b.BottomAppBar(
          currentTab: snapshot.data.currentTab,
          animations: bottomAppBarAnimation,
          audioPlayerTabController: audioPlayerTabController,
        );
      },
    );
  }
}
