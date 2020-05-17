import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/audio_player/audio_player_bloc.dart';
import 'package:piano/widgets/audio_player/mini_audio_player.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final AnimationController controller;

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  double _dragDistance = 0.0;

  double _mapRange(double x1, double x2, double y1, double y2, double value) {
    if (value <= x1) return y1;
    if (value >= x2) return y2;
    return y1 + ((y2 - y1) / (x2 - x1)) * (value - x1);
  }

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      bloc: audioPlayerBloc,
      builder: (context, state) {
        final padding = MediaQuery.of(context).padding;
        final screenHeight = MediaQuery.of(context).size.height - padding.top;
        final animation = Tween(begin: 106.0 / screenHeight, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.controller,
            curve: Interval(0.0, 1.0, curve: Curves.linear),
          ),
        );

        Widget body;
        if (state is AudioPlayerLoaded) {
          body = Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragStart: (details) {
                  _dragDistance = widget.controller.value > 0.0
                      ? screenHeight - 106.0
                      : 0.0;
                },
                onVerticalDragUpdate: (details) {
                  _dragDistance -= details.delta.dy;

                  widget.controller.animateTo(
                    _mapRange(0, screenHeight - 106, 0, 1, _dragDistance),
                    duration: Duration.zero,
                    curve: Curves.linear,
                  );
                },
                onVerticalDragEnd: (details) {
                  bool openPlayer;
                  // If less than 2/5 of the animation in complete close player only if
                  // pointer is moving up with velocity greater than 1300
                  if (widget.controller.value <= 0.4) {
                    openPlayer = details.primaryVelocity <= -1300;
                  }
                  // If more than 2/5 of the animation is complete open player only if
                  // pointer is moving down with velocity greater than 1300
                  else {
                    openPlayer = !(details.primaryVelocity >= 1300);
                  }

                  widget.controller.animateBack(
                    openPlayer ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.ease,
                  );
                },
                child: MiniAudioPlayer(
                  controller: widget.controller,
                  state: state,
                  onPlay: () => audioPlayerBloc.add(Play()),
                  onPause: () => audioPlayerBloc.add(Pause()),
                ),
              ),
            ],
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: TWColors.gray.shade400, blurRadius: 3.0)
            ],
          ),
          child: body != null
              ? SizeTransition(
                  axis: Axis.vertical,
                  axisAlignment: -1.0,
                  sizeFactor: animation,
                  child: Container(
                    height: screenHeight,
                    child: body,
                  ),
                )
              : Container(
                  constraints: BoxConstraints.expand(height: 56),
                ),
        );
      },
    );
  }
}
