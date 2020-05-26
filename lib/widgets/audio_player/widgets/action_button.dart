import 'package:flutter/material.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
    this.fullSized = false,
    @required this.state,
    @required this.onPause,
    @required this.onResume,
  }) : super(key: key);

  final bool fullSized;
  final AudioPlayerActive state;
  final void Function() onPause;
  final void Function() onResume;

  @override
  Widget build(BuildContext context) {
    if (fullSized) {
      return SizedBox(
        height: 64,
        width: 64,
        child: Stack(
          children: <Widget>[
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: TWColors.purple.shade600,
                borderRadius: BorderRadius.circular(900),
              ),
            ),
            _buildButton(),
          ],
        ),
      );
    }

    return SizedBox(
      height: 32,
      width: 32,
      child: Stack(
        children: <Widget>[
          _buildProgressIndicator(),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    if (state.audioState.isLoading) {
      return CircularProgressIndicator(
        value: null,
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(
          TWColors.purple.shade600,
        ),
        backgroundColor: TWColors.gray.shade300,
      );
    }

    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)),
      builder: (context, snapshot) {
        final duration = state.audioState.duration;
        final currentTime = state.audioState.currentTime;

        return CircularProgressIndicator(
          value: currentTime / duration,
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            TWColors.purple.shade600,
          ),
          backgroundColor: TWColors.gray.shade300,
        );
      },
    );
  }

  Widget _buildButton() {
    var color = TWColors.gray.shade600;
    var size = 20.0;
    if (fullSized) {
      color = TWColors.gray.shade100;
      size = 36;
    }

    IconData iconData;
    void Function() onPressed;
    if (state.audioState.isPlaying) {
      iconData = Icons.pause;
      onPressed = onPause;
    } else if (state.audioState.isPaused) {
      iconData = Icons.play_arrow;
      onPressed = onResume;
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
          icon: Icon(iconData, color: color, size: size),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
