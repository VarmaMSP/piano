import 'package:flutter/material.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PreviewPlaybackControls extends StatelessWidget {
  const PreviewPlaybackControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);
    final onPlay =
        () => audioPlayerBloc.transistionState(StateTransistion.play);
    final onPause =
        () => audioPlayerBloc.transistionState(StateTransistion.pause);

    return StreamBuilder<AudioState>(
      stream: audioPlayerBloc.audioState,
      builder: (context, snapshot) => Container(
        height: 32,
        width: 32,
        child: Stack(
          children: <Widget>[
            if (snapshot.data != AudioState.none &&
                snapshot.data != AudioState.playing &&
                snapshot.data != AudioState.paused)
              _buildLoadingIndicator()
            else
              _buildProgressIndicator(audioPlayerBloc.positionState),
            _buildButton(snapshot.data, onPlay, onPause),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return CircularProgressIndicator(
      value: null,
      strokeWidth: 2.5,
      valueColor: AlwaysStoppedAnimation<Color>(TWColors.purple.shade600),
      backgroundColor: TWColors.gray.shade300,
    );
  }

  Widget _buildProgressIndicator(
    Stream<PositionState> positionState,
  ) {
    return StreamBuilder<PositionState>(
      stream: positionState,
      builder: (context, snapshot) {
        return CircularProgressIndicator(
          value: snapshot.hasData ? snapshot.data.percentage : 0.0,
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            TWColors.purple.shade600,
          ),
          backgroundColor: TWColors.gray.shade300,
        );
      },
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

    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          padding: const EdgeInsets.all(0.0),
          icon: Icon(
            iconData,
            color: TWColors.gray.shade600,
            size: 20,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
