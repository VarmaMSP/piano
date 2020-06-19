import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key key, this.animations}) : super(key: key);

  final BottomAppBarAnimation animations;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: -1.0,
      sizeFactor: animations.bottomNavigationBarSize,
      child: Container(
        height: 56.0,
        padding: EdgeInsets.only(top: 2),
        color: Colors.white,
        child: BottomNavigationBar(
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
              icon: Icon(Icons.explore, size: 23.0),
              title: const Text('Explore'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed, size: 23.0),
              title: const Text('Feeds'),
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
