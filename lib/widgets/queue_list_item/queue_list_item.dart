import 'dart:ui';

import 'package:flutter/material.dart';
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
    @required this.nowPlayingPosition,
    @required AudioTrack audioTrack,
  })  : position = audioTrack.position,
        episode = audioTrack.episode,
        podcast = audioTrack.podcast,
        super(key: key);

  final Animation<double> dragAnimation;
  final int position;
  final int nowPlayingPosition;
  final Episode episode;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final t = dragAnimation.value;

    final color = Color.lerp(Colors.white, Colors.grey.shade100, t);
    final elevation = lerpDouble(0, 8, t);

    return Box(
      color: nowPlayingPosition == position ? Colors.grey.shade200 : color,
      elevation: elevation,
      alignment: Alignment.center,
      height: 80,
      child: Container(
        constraints: BoxConstraints.expand(height: 80),
        padding: EdgeInsets.symmetric(vertical: 7.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Handle(
              child: Container(
                padding: EdgeInsets.only(left: 6),
                child: Icon(
                  MdiIcons.dragVertical,
                  color: TWColors.gray.shade700,
                  size: 24,
                ),
              ),
            ),
            if (nowPlayingPosition == position)
              Container(
                width: 26,
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  MdiIcons.play,
                  color: TWColors.gray.shade700,
                  size: 18,
                ),
              )
            else
              Container(
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
              ),
            Thumbnail(podcast: podcast),
            Expanded(
              child: Container(
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
              ),
            ),
            Icon(
              Icons.more_vert,
              color: TWColors.gray.shade600,
              size: 22,
            ),
            Container(width: 8),
          ],
        ),
      ),
    );
  }
}
