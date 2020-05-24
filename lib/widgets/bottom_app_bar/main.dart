import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';
import 'package:phenopod/widgets/audio_player/main.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';

import 'navigation_bar.dart';

class BottomAppBar extends StatefulWidget {
  BottomAppBar({Key key}) : super(key: key);

  @override
  _BottomAppBarState createState() => _BottomAppBarState();
}

class _BottomAppBarState extends State<BottomAppBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight = MediaQuery.of(context).size.height - padding.top;

    final animations = BottomAppBarAnimations(
      screenHeight: screenHeight,
      controller: _controller,
    );

    final body = Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AudioPlayer(animations: animations)),
        Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: NavigationBar(animations: animations)),
      ],
    );

    return BlocListener<AudioPlayerBloc, AudioPlayerState>(
      bloc: BlocProvider.of<AudioPlayerBloc>(context),
      listener: (context, state) {
        state is AudioPlayerDormant
            ? animations.hideAudioPlayerPreview()
            : animations.showAudioPlayerPreview();
      },
      child: AnimatedBuilder(
        animation: animations.appBarHeight,
        child: body,
        builder: (_, child) {
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
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
