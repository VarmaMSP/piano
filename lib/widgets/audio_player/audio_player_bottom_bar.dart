import 'package:flutter/material.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AudioPlayerBottomBar extends StatelessWidget {
  const AudioPlayerBottomBar({
    Key key,
    @required this.animations,
    @required this.tabController,
  }) : super(key: key);

  final BottomAppBarAnimation animations;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 40,
            alignment: Alignment.bottomLeft,
            transform: Matrix4.translationValues(2, 0, 0),
            child: TabBar(
              isScrollable: true,
              indicatorColor: TWColors.yellow.shade400,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 14,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              unselectedLabelColor: TWColors.gray.shade500,
              unselectedLabelStyle: TextStyle(
                fontSize: 14,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w500,
              ),
              controller: tabController,
              tabs: <Widget>[
                Tab(text: 'Now Playing'),
                Tab(text: 'Notes'),
              ],
            ),
          ),
          IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: Icon(
              Icons.playlist_play,
              color: TWColors.gray.shade700,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/queue');
            },
          ),
          IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: Icon(
              Icons.expand_more,
              color: TWColors.gray.shade700,
              size: 24,
            ),
            onPressed: animations.collapseBottomAppBar,
          ),
        ],
      ),
    );
  }
}
