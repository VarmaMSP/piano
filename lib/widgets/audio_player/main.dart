import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'audio_player.dart' as full_audio_player;
import 'audio_player_preview.dart';

class AudioPlayer extends StatelessWidget {
  AudioPlayer({Key key, @required this.animations}) : super(key: key);

  final BottomAppBarAnimations animations;

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final padding = MediaQuery.of(context).padding;
    final screenHeight = MediaQuery.of(context).size.height - padding.top;
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      bloc: audioPlayerBloc,
      builder: (BuildContext context, AudioPlayerState state) {
        Widget body;
        if (state is AudioPlayerActive) {
          body = Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AudioPlayerPreview(
                animations: animations,
                state: state,
                onPlay: () => audioPlayerBloc.add(ResumePlayback()),
                onPause: () => audioPlayerBloc.add(PausePlayback()),
              ),
              Expanded(
                child: full_audio_player.AudioPlayer(
                  animations: animations,
                  state: state,
                  onPlay: () => audioPlayerBloc.add(ResumePlayback()),
                  onPause: () => audioPlayerBloc.add(PausePlayback()),
                  onSeek: (int p) => audioPlayerBloc.add(SeekPlayback(p)),
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
              BoxShadow(color: TWColors.gray.shade400, blurRadius: 2)
            ],
          ),
          child: body ??
              Container(constraints: const BoxConstraints.expand(height: 56)),
        );
      },
    );
  }
}
