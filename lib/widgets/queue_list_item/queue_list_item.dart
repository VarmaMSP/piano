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
    @required AudioTrack audioTrack,
  })  : position = audioTrack.position,
        episode = audioTrack.episode,
        podcast = audioTrack.podcast,
        super(key: key);

  final Animation<double> dragAnimation;
  final int position;
  final Episode episode;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final t = dragAnimation.value;

    final color = Color.lerp(Colors.white, Colors.grey.shade100, t);
    final elevation = lerpDouble(0, 8, t);

    return Box(
      color: color,
      elevation: elevation,
      alignment: Alignment.center,
      height: 80,
      child: Container(
        constraints: BoxConstraints.expand(height: 80),
        padding: EdgeInsets.symmetric(vertical: 10),
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
            Container(
              width: 28,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                position.toString(),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(height: 4),
                    Text(
                      '${formatDuration(seconds: episode.duration)}',
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 0.15,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Icon(
              Icons.more_vert,
              color: TWColors.gray.shade600,
              size: 22,
            ),
            Container(width: 10),
          ],
        ),
      ),
    );
  }
}
