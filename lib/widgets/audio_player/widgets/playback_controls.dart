import 'package:flutter/material.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/service/audio_service/audio_service.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'action_button.dart';

class PlaybackControls extends StatelessWidget {
  PlaybackControls({
    Key key,
  }) : super(key: key);

  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSeekBar(context),
        Container(height: 10),
        _buildControls(),
        Container(height: 20),
      ],
    );
  }

  Widget _buildSeekBar(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<PositionState>(
      stream: audioPlayerBloc.positionState,
      builder: (context, snapshot) {
        final duration =
            snapshot.data?.duration?.inMilliseconds?.toDouble() ?? 0.0;
        final currentTime =
            snapshot.data?.position?.inMilliseconds?.toDouble() ?? 0.0;

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
          child: Icon(Icons.skip_previous, size: 28),
        ),
        Container(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.fast_rewind, size: 28),
        ),
        ActionButton(fullSized: true),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.fast_forward, size: 28),
        ),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.skip_next, size: 28),
        ),
      ],
    );
  }
}
