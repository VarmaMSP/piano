import 'package:flutter/material.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/widgets/audio_player/main.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'navigation_bar.dart';

class BottomAppBar extends StatelessWidget {
  BottomAppBar({Key key, this.animations}) : super(key: key);

  final BottomAppBarAnimations animations;

  @override
  Widget build(BuildContext context) {
    final body = Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AudioPlayer(animations: animations),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: NavigationBar(animations: animations),
        ),
      ],
    );

    return StreamBuilder<AudioPlayerSnapshot>(
      initialData: null,
      stream: Provider.of<AudioPlayerBloc>(context).snapshot,
      builder: (context, s) {
        !s.hasData || s.data.isEmpty
            ? animations.hideAudioPlayerPreview()
            : animations.showAudioPlayerPreview();

        return AnimatedBuilder(
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
        );
      },
    );
  }
}
