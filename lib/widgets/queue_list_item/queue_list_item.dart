import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/model/queue.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/box.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'thumbnail.dart';

class QueueListItem extends StatelessWidget {
  QueueListItem({
    Key key,
    @required this.dragAnimation,
    @required this.play,
    @required this.nowPlayingPosition,
    @required this.removeFromQueue,
    @required AudioTrack audioTrack,
  })  : position = audioTrack.position,
        episode = audioTrack.episode,
        podcast = audioTrack.podcast,
        super(key: key);

  static final double itemHeight = 80;

  final Animation<double> dragAnimation;
  final int nowPlayingPosition;
  final Function play;
  final Function removeFromQueue;
  final int position;
  final Episode episode;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final t = dragAnimation.value;

    final color = nowPlayingPosition == position
        ? Colors.grey.shade200
        : Color.lerp(Colors.white, Colors.grey.shade100, t);
    final elevation = lerpDouble(0, 8, t);

    return Slidable(
      key: Key(episode.id),
      actionPane: const SlidableBehindActionPane(),
      actionExtentRatio: 0.0,
      actions: [
        SlideAction(
          closeOnTap: true,
          color: TWColors.red.shade600,
          child: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ],
      secondaryActions: [
        SlideAction(
          closeOnTap: true,
          color: TWColors.red.shade600,
          child: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          removeFromQueue();
        },
      ),
      child: Box(
        color: color,
        elevation: elevation,
        alignment: Alignment.center,
        height: itemHeight,
        child: GestureDetector(
          onTap: play,
          child: Container(
            constraints: BoxConstraints.expand(height: itemHeight),
            padding: EdgeInsets.symmetric(vertical: 7.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHandler(),
                _buildPosition(context),
                Thumbnail(podcast: podcast),
                Expanded(child: _buildDetails(context)),
                Icon(
                  Icons.more_vert,
                  color: TWColors.gray.shade600,
                  size: 22,
                ),
                Container(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandler() {
    return Handle(
      child: Container(
        padding: EdgeInsets.only(left: 6),
        child: Icon(
          MdiIcons.dragVertical,
          color: TWColors.gray.shade700,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildPosition(BuildContext context) {
    return nowPlayingPosition == position
        ? Container(
            width: 26,
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              MdiIcons.play,
              color: TWColors.gray.shade700,
              size: 18,
            ),
          )
        : Container(
            width: 26,
            padding: EdgeInsets.only(right: 8),
            child: Text(
              '${position - nowPlayingPosition}',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: TWColors.gray.shade800),
            ),
          );
  }

  Widget _buildDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            episode.title,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: TWColors.gray.shade900,
                  fontWeight: FontWeight.w400,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            podcast.title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: TWColors.gray.shade900),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${formatDuration(seconds: episode.duration)}',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: TWColors.gray.shade900),
          ),
        ],
      ),
    );
  }
}
