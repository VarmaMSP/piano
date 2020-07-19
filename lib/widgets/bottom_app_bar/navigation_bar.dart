// Flutter imports:
import 'package:flutter/material.dart' hide Tab;

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key key,
    @required this.animations,
    @required this.currentTab,
  }) : super(key: key);

  final Tab currentTab;
  final BottomAppBarAnimation animations;

  @override
  Widget build(BuildContext context) {
    final appNavigationBloc = Provider.of<AppNavigationBloc>(context);

    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: -1.0,
      sizeFactor: animations.bottomNavigationBarSize,
      child: Container(
        height: 56.0,
        padding: EdgeInsets.only(top: 2),
        color: Colors.white,
        child: BottomNavigationBar(
          currentIndex: currentTab.index,
          onTap: (tabIndex) => appNavigationBloc.pushTab(
            Tab.values[tabIndex],
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
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          // showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 23.0),
              title: const Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed, size: 23.0),
              title: const Text('Subscriptions'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_open, size: 23.0),
              title: const Text('Library'),
            ),
          ],
        ),
      ),
    );
  }
}
