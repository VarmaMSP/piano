import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key key, this.controller}) : super(key: key);

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.3, curve: Curves.linear),
      ),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return SizeTransition(
          axis: Axis.vertical,
          axisAlignment: -1.0,
          sizeFactor: animation,
          child: Container(
            height: 56,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Colors.white,
              selectedItemColor: TWColors.purple.shade600,
              unselectedItemColor: TWColors.gray.shade600,
              selectedLabelStyle: TextStyle(
                height: 1.45,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
              ),
              unselectedLabelStyle: TextStyle(
                height: 1.45,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
              ),
              // showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 21.0),
                  title: const Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore, size: 21.0),
                  title: const Text('Explore'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.rss_feed, size: 21.0),
                  title: const Text('Feeds'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_play, size: 21.0),
                  title: const Text('Playlists'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.face, size: 22.0),
                  title: const Text('Profile'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
