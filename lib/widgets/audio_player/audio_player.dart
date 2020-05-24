import 'dart:developer' as logger;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({
    Key key,
    @required this.animations,
    @required this.state,
    @required this.onPlay,
    @required this.onPause,
    @required this.onSeek,
  }) : super(key: key);

  final BottomAppBarAnimations animations;
  final AudioPlayerActive state;
  final void Function() onPlay;
  final void Function() onPause;
  final void Function(int) onSeek;

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animations.playerBackgroundColor,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 350),
              padding: const EdgeInsets.only(left: 16, right: 16),
              color: widget.animations.playerBackgroundColor.value,
              child: _seekBar(),
            ),
            Expanded(
                child: FlatButton(
              onPressed: () {
                logger.log('Pressed');
              },
              child: Text('CLICK THIS BUTTON'),
            )),
          ],
        );
      },
    );
  }

  Widget _seekBar() {
    double _tmpSeekPosition;

    return StreamBuilder<double>(
      stream: Rx.combineLatest2<double, double, double>(
        Stream.periodic(Duration(milliseconds: 200)),
        _dragPositionSubject.stream,
        (_, x) => x,
      ),
      builder: (context, snapshot) {
        var duration = widget.state.audioState.duration?.toDouble() ?? 0.0;
        var currentTime = _tmpSeekPosition ??
            snapshot.data ??
            widget.state.audioState.currentTime?.toDouble() ??
            0.0;
        currentTime = max(0.0, min(currentTime, duration));

        var parsedDurations =
            _parseDuration(currentTime.toInt(), duration.toInt());

        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(parsedDurations[0]),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.red[700],
                  inactiveTrackColor: Colors.red[100],
                  trackHeight: 3,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.5),
                  thumbColor: Colors.redAccent,
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0),
                  inactiveTickMarkColor: Colors.red[100],
                ),
                child: Slider(
                  min: 0.0,
                  max: duration,
                  value: currentTime,
                  onChanged: (value) {
                    _dragPositionSubject.add(value);
                  },
                  onChangeEnd: (value) {
                    _tmpSeekPosition = value.toInt().toDouble();
                    widget.onSeek(value.toInt());
                    _dragPositionSubject.add(null);
                  },
                ),
              ),
            ),
            Text(parsedDurations[1]),
          ],
        );
      },
    );
  }

  List<String> _parseDuration(int currentTime, int duration) {
    RegExp regex;
    if (duration < 60 * 60 * 1000) {
      regex = RegExp(r'\d\d:(\d\d:\d\d)');
    } else if (duration < 10 * 60 * 60 * 1000) {
      regex = RegExp(r'\d(\d:\d\d:\d\d)');
    } else {
      regex = RegExp(r'(\d\d:\d\d:\d\d)');
    }

    return <String>[
      regex
          .firstMatch(DateTime(0, 0, 0, 0, 0, 0, currentTime).toIso8601String())
          ?.group(1),
      regex
          .firstMatch(DateTime(0, 0, 0, 0, 0, 0, duration).toIso8601String())
          ?.group(1)
    ];
  }
}
