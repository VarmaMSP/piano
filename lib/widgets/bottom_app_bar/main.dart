import 'package:flutter/material.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart' as n;
import 'package:phenopod/model/main.dart';
import 'package:phenopod/widgets/audio_player/main.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'navigation_bar.dart';

class BottomAppBar extends StatelessWidget {
  BottomAppBar({
    Key key,
    @required this.currentTab,
    @required this.animations,
    @required this.audioPlayerTabController,
  }) : super(key: key);

  final n.Tab currentTab;
  final BottomAppBarAnimation animations;
  final TabController audioPlayerTabController;

  @override
  Widget build(BuildContext context) {
    final body = Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AudioPlayer(
            animations: animations,
            tabController: audioPlayerTabController,
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: NavigationBar(
            currentTab: currentTab,
            animations: animations,
          ),
        ),
      ],
    );

    return StreamBuilder<AudioTrack>(
      stream: Provider.of<AudioPlayerBloc>(context).nowPlaying,
      builder: (context, snapshot) {
        !snapshot.hasData
            ? animations.hideAudioPlayerPreview()
            : animations.showAudioPlayerPreview();

        return AnimatedBuilder(
          animation: animations.appBarHeight,
          child: body,
          builder: (context, child) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragStart: animations.verticalDragStartHandler,
              onVerticalDragUpdate: animations.verticalDragUpdateHandler,
              onVerticalDragEnd: animations.verticalDragEndHandler,
              child: Container(
                height: animations.appBarHeight.value,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: TWColors.gray.shade400, blurRadius: 2),
                  ],
                ),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
