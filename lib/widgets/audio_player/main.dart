import 'package:flutter/material.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'audio_player.dart' as full_audio_player;
import 'audio_player_preview.dart';

class AudioPlayer extends StatelessWidget {
  AudioPlayer({Key key, @required this.animations}) : super(key: key);

  final BottomAppBarAnimations animations;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight = MediaQuery.of(context).size.height - padding.top;
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<AudioPlayerSnapshot>(
      initialData: null,
      stream: audioPlayerBloc.snapshot,
      builder: (context, snapshot) {
        Widget body;
        if (snapshot.hasData) {
          body = Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AudioPlayerPreview(
                animations: animations,
                nowPlaying: snapshot.data.nowPlaying,
                onPlay: () =>
                    audioPlayerBloc.transistionState(StateTransistion.play),
                onPause: () =>
                    audioPlayerBloc.transistionState(StateTransistion.pause),
              ),
              Expanded(
                child: full_audio_player.AudioPlayer(
                  animations: animations,
                  nowPlaying: snapshot.data.nowPlaying,
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
