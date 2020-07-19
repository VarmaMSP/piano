// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/model/queue.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/box.dart';
import 'package:phenopod/widgets/download_progress_indicator.dart';
import 'package:phenopod/widgets/queue_list_item/menu.dart';
import 'thumbnail.dart';

class QueueListItem extends StatelessWidget {
  QueueListItem({
    Key key,
    @required this.trackCount,
    @required this.nowPlayingPosition,
    @required this.audioTrack,
    @required this.dragAnimation,
    @required this.transitionQueue,
  });

  static final double itemHeight = 80;

  final int trackCount;
  final int nowPlayingPosition;
  final AudioTrack audioTrack;
  final Animation<double> dragAnimation;
  final void Function(QueueTransition) transitionQueue;

  @override
  Widget build(BuildContext context) {
    final t = dragAnimation.value;

    final color = nowPlayingPosition == audioTrack.position
        ? Colors.grey.shade200
        : Color.lerp(Colors.white, Colors.grey.shade100, t);
    final elevation = lerpDouble(0, 8, t);

    final lighten = audioTrack.position < nowPlayingPosition;
    final background = ({bool alignRight}) => Container(
          constraints: BoxConstraints.expand(),
          padding: alignRight
              ? EdgeInsets.only(right: 12)
              : EdgeInsets.only(left: 12),
          alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
          color: TWColors.red.shade600,
          child: Icon(MdiIcons.deleteOutline, color: Colors.white, size: 28),
        );

    return Dismissible(
      key: Key(audioTrack.episode.id),
      background: background(alignRight: false),
      secondaryBackground: background(alignRight: true),
      onDismissed: (direction) => transitionQueue(
        QueueTransition.removeTrack(position: audioTrack.position),
      ),
      child: Box(
        color: color,
        elevation: elevation,
        alignment: Alignment.center,
        height: itemHeight,
        child: GestureDetector(
          onTap: () => transitionQueue(
            QueueTransition.playTrack(position: audioTrack.position),
          ),
          child: Container(
            constraints: BoxConstraints.expand(height: itemHeight),
            padding: EdgeInsets.symmetric(vertical: 7.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHandle(context, lighten: lighten),
                Thumbnail(podcast: audioTrack.podcast, lighten: lighten),
                Expanded(child: _buildDetails(context, lighten: lighten)),
                Menu(
                  trackCount: trackCount,
                  nowPlayingPosition: nowPlayingPosition,
                  audioTrack: audioTrack,
                  lighten: lighten,
                  transitionQueue: transitionQueue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandle(BuildContext context, {bool lighten}) {
    final dragIcon = Container(
      padding: EdgeInsets.only(left: 6),
      child: Icon(
        MdiIcons.dragVertical,
        color: lighten ? TWColors.gray.shade600 : TWColors.gray.shade900,
        size: 24,
      ),
    );

    final position = Container(
      width: 26,
      padding: EdgeInsets.only(right: 8),
      child: nowPlayingPosition == audioTrack.position
          ? Icon(
              MdiIcons.play,
              color: TWColors.gray.shade700,
              size: 18,
            )
          : Text(
              '${audioTrack.position - nowPlayingPosition}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: lighten
                        ? TWColors.gray.shade600
                        : TWColors.gray.shade900,
                  ),
            ),
    );

    return Handle(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(children: [dragIcon, position])
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context, {bool lighten}) {
    final textColor = lighten ? TWColors.gray.shade600 : TWColors.gray.shade900;

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            audioTrack.episode.title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            audioTrack.podcast.title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${formatDuration(seconds: audioTrack.episode.duration)}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: textColor, fontSize: 11.75),
              ),
              Container(width: 10),
              DownloadProgressIndicator(episodeId: audioTrack.episode.id),
            ],
          ),
        ],
      ),
    );
  }
}
