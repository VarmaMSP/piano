import 'package:flutter/material.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
    this.fullSized = false,
    @required this.onPause,
    @required this.onResume,
  }) : super(key: key);

  final bool fullSized;
  final void Function() onPause;
  final void Function() onResume;

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<AudioState>(
      stream: audioPlayerBloc.audioState,
      builder: (context, snapshot) {
        return fullSized
            ? SizedBox(
                height: 56,
                width: 56,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: TWColors.purple.shade600,
                        borderRadius: BorderRadius.circular(900),
                      ),
                    ),
                    _buildButton(snapshot.data),
                  ],
                ),
              )
            : SizedBox(
                height: 32,
                width: 32,
                child: Stack(
                  children: <Widget>[
                    _buildProgressIndicator(context, snapshot.data),
                    _buildButton(snapshot.data),
                  ],
                ),
              );
      },
    );
  }

  Widget _buildProgressIndicator(BuildContext context, AudioState audioState) {
    final showLoading = audioState != AudioState.none &&
        audioState != AudioState.playing &&
        audioState != AudioState.paused;

    if (showLoading) {
      return CircularProgressIndicator(
        value: null,
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          TWColors.purple.shade600,
        ),
        backgroundColor: TWColors.gray.shade300,
      );
    }

    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);
    return StreamBuilder<PositionState>(
      stream: audioPlayerBloc.positionState,
      builder: (context, snapshot) {
        final duration =
            snapshot.hasData ? snapshot.data.duration.inMilliseconds : 1;
        final currentTime =
            snapshot.hasData ? snapshot.data.position.inMilliseconds : 0;

        return CircularProgressIndicator(
          value: currentTime / duration,
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            TWColors.purple.shade600,
          ),
          backgroundColor: TWColors.gray.shade300,
        );
      },
    );
  }

  Widget _buildButton(AudioState audioState) {
    var color = TWColors.gray.shade600;
    var size = 20.0;
    if (fullSized) {
      color = TWColors.gray.shade100;
      size = 32;
    }

    IconData iconData;
    void Function() onPressed;
    if (audioState == AudioState.playing) {
      iconData = Icons.pause;
      onPressed = onPause;
    } else if (audioState == AudioState.paused) {
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
