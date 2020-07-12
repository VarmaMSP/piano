import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:seekbar/seekbar.dart' as flutter_seek_bar;
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tuple/tuple.dart';

class SeekBar extends StatefulWidget {
  SeekBar({Key key}) : super(key: key);

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  final BehaviorSubject<PlaybackPosition> _seekPlaybackPosition =
      BehaviorSubject<PlaybackPosition>.seeded(null);

  @override
  void dispose() {
    _seekPlaybackPosition.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return StreamBuilder<Tuple2<PlaybackPosition, PlaybackPosition>>(
      stream: Rx.combineLatest2(
        audioPlayerBloc.positionState,
        _seekPlaybackPosition,
        (a, b) => Tuple2(a, b),
      ),
      builder: (context, snapshot) {
        var currentTime = Duration.zero;
        var duration = Duration.zero;
        var progress = 0.0;
        if (snapshot.hasData) {
          final positionState = snapshot.data.item2 ?? snapshot.data.item1;
          if (positionState != null) {
            currentTime = positionState.position;
            duration = positionState.duration;
            progress = positionState.percentage;
          }
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
                  onStartTrackingTouch: () {
                    _seekPlaybackPosition.add(PlaybackPosition(
                      duration: duration,
                      position: currentTime,
                      percentage: progress,
                    ));
                  },
                  onProgressChanged: (percentage) {
                    _seekPlaybackPosition.add(PlaybackPosition(
                      duration: duration,
                      position: Duration(
                        milliseconds:
                            (duration.inMilliseconds * percentage).round(),
                      ),
                      percentage: percentage,
                    ));
                  },
                  onStopTrackingTouch: () {
                    audioPlayerBloc.transitionPosition(currentTime);
                    _seekPlaybackPosition.add(null);
                  },
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
