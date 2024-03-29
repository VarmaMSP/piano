// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animations/bottom_app_bar_animation.dart';
import 'package:phenopod/blocs/app_navigation_bloc.dart';
import 'package:phenopod/models/main.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key key,
    @required this.animations,
    @required this.currentTab,
  }) : super(key: key);

  final AppTab currentTab;
  final BottomAppBarAnimation animations;

  @override
  Widget build(BuildContext context) {
    final appNavigationBloc = Provider.of<AppNavigationBloc>(context);

    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: -1.0,
      sizeFactor: animations.bottomNavigationBarSize,
      child: Container(
        height: 57.0,
        padding: EdgeInsets.only(top: 2),
        color: Colors.white,
        child: BottomNavigationBar(
          currentIndex: currentTab.index,
          onTap: (tabIndex) => appNavigationBloc.pushTab(
            AppTab.values[tabIndex],
          ),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.white,
          selectedItemColor: TWColors.purple.shade600,
          unselectedItemColor: TWColors.gray.shade500,
          selectedLabelStyle: TextStyle(
            height: 1.55,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
          unselectedLabelStyle: TextStyle(
            height: 1.55,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, size: 24.0),
              title: const Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed_rounded, size: 24.0),
              title: const Text('Subscriptions'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_rounded, size: 24.0),
              title: const Text('Library'),
            ),
          ],
        ),
      ),
    );
  }
}
