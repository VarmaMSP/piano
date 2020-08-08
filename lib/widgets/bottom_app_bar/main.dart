// Flutter imports:
import 'package:flutter/material.dart' hide Tab;

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animations/bottom_app_bar_animation.dart';
import 'package:phenopod/blocs/app_navigation_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/audio_player/main.dart';
import 'navigation_bar.dart';

class BottomAppBar extends StatefulWidget {
  BottomAppBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomAppBarState createState() => _BottomAppBarState();
}

class _BottomAppBarState extends State<BottomAppBar> {
  @override
  void initState() {
    super.initState();

    final appNavigationBloc = Provider.of<AppNavigationBloc>(
      context,
      listen: false,
    );

    appNavigationBloc.bottomAppBarAnimation = BottomAppBarAnimation.New(
      screenHeight: getScreenHeight(),
      tabController: appNavigationBloc.playerTabController,
      animationController: appNavigationBloc.playerAnimationController,
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);
    final appNavigationBloc = Provider.of<AppNavigationBloc>(context);
    final bottomAppBarAnimation = appNavigationBloc.bottomAppBarAnimation;
    final audioPlayerTabController = appNavigationBloc.playerTabController;

    return StreamBuilder<TabHistory>(
      initialData: TabHistory.init(),
      stream: appNavigationBloc.tabHistory,
      builder: (context, snapshot) {
        final currentTab = snapshot.data.currentTab;

        return StreamBuilder<AudioTrack>(
          initialData: store.audioPlayer.getQueue().nowPlaying,
          stream: store.audioPlayer.watchQueue().map((q) => q.nowPlaying),
          builder: (context, snapshot) {
            !snapshot.hasData
                ? bottomAppBarAnimation.hideAudioPlayerPreview()
                : bottomAppBarAnimation.showAudioPlayerPreview();

            return _buildBody(
              currentTab: currentTab,
              bottomAppBarAnimation: bottomAppBarAnimation,
              audioPlayerTabController: audioPlayerTabController,
            );
          },
        );
      },
    );
  }

  Widget _buildBody({
    @required AppTab currentTab,
    @required TabController audioPlayerTabController,
    @required BottomAppBarAnimation bottomAppBarAnimation,
  }) {
    final body = Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AudioPlayer(
            tabController: audioPlayerTabController,
            animations: bottomAppBarAnimation,
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: NavigationBar(
            currentTab: currentTab,
            animations: bottomAppBarAnimation,
          ),
        ),
      ],
    );

    return AnimatedBuilder(
      animation: bottomAppBarAnimation.appBarHeight,
      child: body,
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragStart: bottomAppBarAnimation.verticalDragStartHandler,
          onVerticalDragUpdate: bottomAppBarAnimation.verticalDragUpdateHandler,
          onVerticalDragEnd: bottomAppBarAnimation.verticalDragEndHandler,
          child: Container(
            height: bottomAppBarAnimation.appBarHeight.value,
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
  }
}
