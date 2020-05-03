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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            episode.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: TWColors.gray.shade900,
              fontWeight: FontWeight.w500,
              height: 1.3,
              letterSpacing: 0.2,
            ),
            maxLines: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            'S01 E10 - 8 days ago',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: TWColors.gray.shade800,
              height: 1.2,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
