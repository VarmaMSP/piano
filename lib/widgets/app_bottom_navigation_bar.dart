import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      selectedIconTheme: IconThemeData(size: 22),
      selectedLabelStyle: TextStyle(
        height: 1.5,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.45,
      ),
      selectedItemColor: TWColors.blue.shade700,
      unselectedIconTheme: IconThemeData(size: 22),
      unselectedItemColor: TWColors.gray.shade600,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rss_feed),
          title: Text('Feeds'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_play),
          title: Text('Playlists'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.face),
          title: Text('Profile'),
        ),
      ],
    );
  }
}
