import 'dart:math';

import 'package:flutter/material.dart';
import 'package:phenopod/utils/format.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';

import 'action_button.dart';

class PlaybackControls extends StatelessWidget {
  PlaybackControls({
    Key key,
    @required this.state,
    @required this.onPlay,
    @required this.onPause,
    @required this.onSeek,
  }) : super(key: key);

  final AudioPlayerActive state;
  final void Function() onPlay;
  final void Function() onPause;
  final void Function(int) onSeek;
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSeekBar(),
        Container(height: 18),
        _buildControls(),
        Container(height: 20),
      ],
    );
  }

  Widget _buildSeekBar() {
    double _tmpSeekPosition;

    return StreamBuilder<double>(
      stream: Rx.combineLatest2<double, double, double>(
        Stream.periodic(Duration(milliseconds: 200)),
        _dragPositionSubject.stream,
        (_, x) => x,
      ),
      builder: (context, snapshot) {
        var duration = state.audioState.duration?.toDouble() ?? 0.0;
        var currentTime = _tmpSeekPosition ??
            snapshot.data ??
            state.audioState.currentTime?.toDouble() ??
            0.0;
        currentTime = max(0.0, min(currentTime, duration));

        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              formatDuration(milliSeconds: currentTime.floor()),
              style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.2,
                color: TWColors.gray.shade800,
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.red[700],
                  inactiveTrackColor: Colors.red[100],
                  trackHeight: 2.5,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                  thumbColor: Colors.redAccent,
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 16.0),
                  inactiveTickMarkColor: Colors.red[100],
                ),
                child: Slider(
                  min: 0.0,
                  max: duration,
                  value: currentTime,
                  onChanged: _dragPositionSubject.add,
                  onChangeEnd: (value) {
                    _tmpSeekPosition = value.toInt().toDouble();
                    onSeek(value.toInt());
                    _dragPositionSubject.add(null);
                  },
                ),
              ),
            ),
            Text(
              formatDuration(milliSeconds: duration.floor()),
              style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.2,
                color: TWColors.gray.shade800,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.skip_previous, size: 32),
        ),
        Container(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.fast_rewind, size: 32),
        ),
        ActionButton(
          state: state,
          onPause: onPause,
          onResume: onPlay,
          fullSized: true,
        ),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.fast_forward, size: 32),
        ),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.skip_next, size: 32),
        ),
      ],
    );
  }
}
