// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animations/bottom_app_bar_animation.dart';
import 'package:phenopod/utils/utils.dart';

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
      height: getScreenHeight() < 850 ? 60 : 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTabs(),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 40,
      alignment: Alignment.bottomLeft,
      transform: Matrix4.translationValues(10, 0, 0),
      margin: EdgeInsets.only(top: 6),
      child: TabBar(
        isScrollable: true,
        indicator: MD2Indicator(
          indicatorHeight: 4,
          indicatorColor: Color(0xffffbe0b),
          indicatorSize: MD2IndicatorSize.full,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: TWColors.gray.shade900,
        labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
        labelStyle: TextStyle(
          fontSize: 14,
          letterSpacing: 0.4,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelColor: TWColors.gray.shade500,
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          letterSpacing: 0.4,
          fontWeight: FontWeight.w500,
        ),
        controller: tabController,
        tabs: <Widget>[
          Tab(text: 'Now Playing'),
          Tab(text: 'Notes'),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          iconSize: 28,
          color: TWColors.gray.shade700,
          icon: Icon(Icons.expand_more_rounded),
          onPressed: animations.collapseBottomAppBar,
          enableFeedback: true,
        ),
        IconButton(
          iconSize: 26,
          color: TWColors.gray.shade700,
          icon: Icon(Icons.playlist_play_rounded),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pushNamed('/queue');
          },
          enableFeedback: true,
        ),
        IconButton(
          iconSize: 24,
          color: TWColors.gray.shade700,
          icon: Icon(Icons.more_vert_rounded),
          onPressed: () {},
          enableFeedback: true,
        ),
      ],
    );
  }
}
