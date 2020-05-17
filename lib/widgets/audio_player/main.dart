import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/audio_player/audio_player_bloc.dart';
import 'package:piano/widgets/audio_player/mini_audio_player.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({Key key, @required this.controller}) : super(key: key);

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      bloc: audioPlayerBloc,
      builder: (context, state) {
        if (state is AudioPlayerInitial) {
          return Container(
            constraints: BoxConstraints.expand(height: 56),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: TWColors.gray.shade300, blurRadius: 2.0)
              ],
            ),
          );
        }

        final padding = MediaQuery.of(context).padding;
        final screenHeight =
            MediaQuery.of(context).size.height - padding.top - padding.bottom;
        final animation = Tween(begin: 106.0 / screenHeight, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.ease),
          ),
        );

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: TWColors.gray.shade400, blurRadius: 3.0),
            ],
          ),
          child: SizeTransition(
            axis: Axis.vertical,
            axisAlignment: -1.0,
            sizeFactor: animation,
            child: Container(
              height: screenHeight,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MiniAudioPlayer(
                    controller: controller,
                    state: state,
                    onPlay: () => audioPlayerBloc.add(Play()),
                    onPause: () => audioPlayerBloc.add(Pause()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
