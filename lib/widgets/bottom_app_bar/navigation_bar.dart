// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart' as n;

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key key,
    @required this.animations,
    @required this.currentTab,
  }) : super(key: key);

  final n.Tab currentTab;
  final BottomAppBarAnimation animations;

  @override
  Widget build(BuildContext context) {
    final appNavigationBloc = Provider.of<n.AppNavigationBloc>(context);

    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: -1.0,
      sizeFactor: animations.bottomNavigationBarSize,
      child: Container(
        height: 56.0,
        padding: EdgeInsets.only(top: 2),
        color: Colors.white,
        child: BottomNavigationBar(
          currentIndex: (() {
            if (currentTab == n.Tab.home) {
              return 0;
            } else if (currentTab == n.Tab.subscriptions) {
              return 1;
            } else {
              return 0;
            }
          })(),
          onTap: (value) {
            if (value == 0) {
              appNavigationBloc.pushTab(n.Tab.home);
            } else if (value == 1) {
              appNavigationBloc.pushTab(n.Tab.subscriptions);
            }
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.white,
          selectedItemColor: TWColors.purple.shade600,
          unselectedItemColor: TWColors.gray.shade600,
          selectedLabelStyle: TextStyle(
            height: 1.55,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.45,
          ),
          unselectedLabelStyle: TextStyle(
            height: 1.55,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.45,
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
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.folder_open, size: 23.0),
            //   title: const Text('Library'),
            // ),
          ],
        ),
      ),
    );
  }
}
