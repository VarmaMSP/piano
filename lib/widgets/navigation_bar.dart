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
        curve: const Interval(0.0, 0.55, curve: Curves.linear),
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
                height: 1.5,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.45,
              ),
              unselectedLabelStyle: TextStyle(
                height: 1.5,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.45,
              ),
              // showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 21.0),
                  title: const Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore, size: 19.0),
                  title: const Text('Explore'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.rss_feed, size: 19.0),
                  title: const Text('Feeds'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_play, size: 21.0),
                  title: const Text('Playlists'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.face, size: 19.0),
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
