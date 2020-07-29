// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animations/bottom_app_bar_animation.dart';
import 'package:phenopod/blocs/audio_player_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/audio_player/audio_player_bottom_bar.dart';
import 'audio_player.dart' as full_audio_player;
import 'audio_player_preview.dart';

class AudioPlayer extends StatelessWidget {
  AudioPlayer({
    Key key,
    @required this.animations,
    @required this.tabController,
  }) : super(key: key);

  final BottomAppBarAnimation animations;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final screenHeight = getScreenHeight();
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<AudioTrack>(
      stream: audioPlayerBloc.nowPlaying,
      builder: (context, snapshot) {
        Widget body;
        if (snapshot.hasData) {
          body = Column(
            children: <Widget>[
              AudioPlayerPreview(
                animations: animations,
                nowPlaying: snapshot.data,
              ),
              Container(
                constraints: BoxConstraints.expand(height: screenHeight),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: full_audio_player.AudioPlayer(
                        animations: animations,
                        tabController: tabController,
                        nowPlaying: snapshot.data,
                      ),
                    ),
                    AudioPlayerBottomBar(
                      animations: animations,
                      tabController: tabController,
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: TWColors.gray.shade100,
                blurRadius: 3,
              )
            ],
          ),
          child: body ??
              Container(
                constraints: const BoxConstraints.expand(height: 56),
              ),
        );
      },
    );
  }
}
