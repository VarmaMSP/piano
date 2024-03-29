// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/blocs/audio_player_bloc.dart';
import 'package:phenopod/models/main.dart';

class PlaybackControls extends StatelessWidget {
  PlaybackControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);
    final onPlay = () => audioPlayerBloc.addAudioAction(AudioAction.play);
    final onPause = () => audioPlayerBloc.addAudioAction(AudioAction.pause);
    final onFastForward = () => audioPlayerBloc.addAudioAction(
          AudioAction.fastforward,
        );
    final onRewind = () => audioPlayerBloc.addAudioAction(AudioAction.rewind);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 32),
          child: IconButton(
            icon: Icon(
              Icons.fast_rewind_rounded,
              color: TWColors.gray.shade700,
              size: 24.0,
            ),
            onPressed: onRewind,
          ),
        ),
        StreamBuilder<AudioState>(
          stream: audioPlayerBloc.audioState,
          builder: (context, snapshot) {
            return _buildButton(snapshot.data, onPlay, onPause);
          },
        ),
        Container(
          padding: EdgeInsets.only(left: 32),
          child: IconButton(
            icon: Icon(
              Icons.fast_forward_rounded,
              color: TWColors.gray.shade700,
              size: 24.0,
            ),
            onPressed: onFastForward,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
    AudioState audioState,
    void Function() onPlay,
    void Function() onPause,
  ) {
    IconData iconData;
    void Function() onPressed;
    if (audioState == AudioState.playing) {
      iconData = Icons.pause_rounded;
      onPressed = onPause;
    } else if (audioState == AudioState.paused) {
      iconData = Icons.play_arrow_rounded;
      onPressed = onPlay;
    } else if (audioState == AudioState.none) {
      iconData = Icons.play_arrow_rounded;
      onPressed = onPlay;
    } else {
      iconData = Icons.play_arrow_rounded;
      onPressed = () {};
    }

    return Container(
      height: 56,
      width: 56,
      child: Stack(
        children: <Widget>[
          Container(
            height: 56,
            width: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: TWColors.purple.shade600,
              borderRadius: BorderRadius.circular(900),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  iconData,
                  color: TWColors.gray.shade100,
                  size: 24.0,
                ),
                onPressed: onPressed,
              ),
            ),
          )
        ],
      ),
    );
  }
}
