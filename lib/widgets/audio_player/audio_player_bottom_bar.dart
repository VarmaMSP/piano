import 'package:flutter/material.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/model/main.dart';
import 'package:provider/provider.dart';
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
      height: getScreenHeight(context) < 850 ? 80 : 120,
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
      height: 45,
      alignment: Alignment.bottomLeft,
      transform: Matrix4.translationValues(10, 0, 0),
      child: TabBar(
        isScrollable: true,
        indicatorColor: TWColors.yellow.shade400,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 4,
        labelColor: TWColors.gray.shade900,
        labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
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
    return StreamBuilder<Queue>(
      stream: Provider.of<AudioPlayerBloc>(context).queue,
      builder: (context, snapshot) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 42,
              width: 42,
              child: IconButton(
                iconSize: 28,
                color: TWColors.gray.shade700,
                icon: Icon(Icons.expand_more),
                onPressed: animations.collapseBottomAppBar,
                enableFeedback: true,
              ),
            ),
            if (snapshot.hasData)
              Container(
                height: 42,
                width: 42,
                child: IconButton(
                  iconSize: 28,
                  color: TWColors.gray.shade700,
                  icon: Icon(Icons.playlist_play),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/queue');
                  },
                  enableFeedback: true,
                ),
              ),
            Container(
              height: 42,
              width: 42,
              child: IconButton(
                iconSize: 24,
                color: TWColors.gray.shade700,
                icon: Icon(Icons.more_vert),
                onPressed: () {},
                enableFeedback: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
