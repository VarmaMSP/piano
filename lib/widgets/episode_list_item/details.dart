import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Details extends StatelessWidget {
  final Episode episode;
  final Podcast podcast;

  const Details({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = Text(
      episode.title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 15.5,
        color: TWColors.teal.shade900,
        height: 1.3,
        letterSpacing: 0.28,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 2,
    );

    return Transform.translate(
      offset: Offset(0, -2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: title,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'S01 E10 - 8 days ago',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: TWColors.teal.shade900,
                height: 1.2,
                letterSpacing: 0.2,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
