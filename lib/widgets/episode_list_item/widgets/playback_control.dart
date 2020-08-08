// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:badges/badges.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/utils/time.dart' as timeutils;

class PlaybackControl extends StatelessWidget {
  const PlaybackControl({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  final Episode episode;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Badge(
          badgeContent: _buildQueueBadge(context),
          elevation: 0,
          padding: EdgeInsets.zero,
          position: BadgePosition(left: -12),
          badgeColor: Colors.transparent,
          animationType: BadgeAnimationType.scale,
          animationDuration: Duration.zero,
          showBadge: podcast.id == 'PdRvqd',
          child: _buildPausePlayButton(context),
        ),
        Container(height: 6.0),
        _buildDuration(context),
      ],
    );
  }

  Widget _buildQueueBadge(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: TWColors.gray.shade700,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 1.0),
          child: Text(
            '11',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.15,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildPausePlayButton(BuildContext context) {
    return Container(
      height: 38,
      width: 38,
      alignment: Alignment.center,
      child: SizedBox(
        height: 32,
        width: 32,
        child: Stack(
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 2.5,
              value: 0.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.purple.shade600,
              ),
              backgroundColor: TWColors.gray.shade300,
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.grey.shade600,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDuration(BuildContext context) {
    return Text(
      timeutils.formatDurationToWords(Duration(seconds: episode.duration)),
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            fontSize: 11,
            color: TWColors.gray.shade900,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
    );
  }
}
