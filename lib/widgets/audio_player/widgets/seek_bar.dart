import 'package:flutter/material.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:seekbar/seekbar.dart' as flutter_seek_bar;
import 'package:tailwind_colors/tailwind_colors.dart';

class SeekBar extends StatelessWidget {
  SeekBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<PositionState>(
      stream: audioPlayerBloc.positionState,
      builder: (context, snapshot) {
        var currentTime = Duration.zero;
        var duration = Duration.zero;
        var progress = 0.0;
        if (snapshot.hasData) {
          currentTime = snapshot.data.position;
          duration = snapshot.data.duration;
          progress = 0.0;
        }

        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              formatDuration(seconds: currentTime.inSeconds),
              style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.2,
                color: TWColors.gray.shade800,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: flutter_seek_bar.SeekBar(
                  value: progress,
                  secondValue: 0.0,
                  barColor: TWColors.gray.shade300,
                  progressColor: TWColors.purple.shade600,
                  secondProgressColor: TWColors.gray.shade400,
                  thumbColor: TWColors.purple.shade600,
                  onStartTrackingTouch: () {},
                  onProgressChanged: (_) {},
                  onStopTrackingTouch: () {},
                ),
              ),
            ),
            Text(
              formatDuration(seconds: duration.inSeconds),
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
}
