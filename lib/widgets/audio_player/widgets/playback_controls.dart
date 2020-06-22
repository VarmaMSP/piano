import 'package:flutter/material.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PlaybackControls extends StatelessWidget {
  PlaybackControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);
    final onPlay =
        () => audioPlayerBloc.transistionState(StateTransistion.play);
    final onPause =
        () => audioPlayerBloc.transistionState(StateTransistion.pause);
    final onFastForward =
        () => audioPlayerBloc.transistionState(StateTransistion.fastforward);
    final onRewind =
        () => audioPlayerBloc.transistionState(StateTransistion.rewind);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 32),
          child: IconButton(
            icon: Icon(
              Icons.fast_rewind,
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
              Icons.fast_forward,
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
      iconData = Icons.pause;
      onPressed = onPause;
    } else if (audioState == AudioState.paused) {
      iconData = Icons.play_arrow;
      onPressed = onPlay;
    } else if (audioState == AudioState.none) {
      iconData = Icons.play_arrow;
      onPressed = onPlay;
    } else {
      iconData = Icons.play_arrow;
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
