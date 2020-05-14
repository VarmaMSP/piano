import 'package:flutter/material.dart';
import 'package:piano/widgets/bottom_navigation_bar/audio_player.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 1.0,
        )
      ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AudioPlayer(),
          Container(
            height: 52,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0,
              selectedIconTheme: IconThemeData(size: 20),
              selectedLabelStyle: TextStyle(
                height: 1.5,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.45,
              ),
              selectedItemColor: TWColors.blue.shade700,
              showUnselectedLabels: false,
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
            ),
          ),
        ],
      ),
    );
  }
}
