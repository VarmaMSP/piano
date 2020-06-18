import 'package:flutter/material.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'audio_player.dart' as full_audio_player;
import 'audio_player_preview.dart';

class AudioPlayer extends StatelessWidget {
  AudioPlayer({Key key, @required this.animations}) : super(key: key);

  final BottomAppBarAnimation animations;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight = MediaQuery.of(context).size.height - padding.top;
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<AudioPlayerSnapshot>(
      initialData: null,
      stream: audioPlayerBloc.snapshot,
      builder: (context, s) {
        Widget body;
        if (s.hasData && !s.data.isEmpty) {
          body = Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AudioPlayerPreview(
                animations: animations,
                nowPlaying: s.data.nowPlaying,
                onPlay: () =>
                    audioPlayerBloc.transistionState(StateTransistion.play),
                onPause: () =>
                    audioPlayerBloc.transistionState(StateTransistion.pause),
              ),
              Expanded(
                child: full_audio_player.AudioPlayer(
                  animations: animations,
                  nowPlaying: s.data.nowPlaying,
                  onPlay: () =>
                      audioPlayerBloc.transistionState(StateTransistion.play),
                  onPause: () =>
                      audioPlayerBloc.transistionState(StateTransistion.pause),
                  onSeek: (int p) =>
                      audioPlayerBloc.transistionState(StateTransistion.play),
                ),
              ),
            ],
          );
        }

        return Container(
          constraints: BoxConstraints.expand(height: screenHeight),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(color: TWColors.gray.shade100, blurRadius: 3)
            ],
          ),
          child: body ??
              Container(constraints: const BoxConstraints.expand(height: 56)),
        );
      },
    );
  }
}
