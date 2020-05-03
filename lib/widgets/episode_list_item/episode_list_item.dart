import 'package:flutter/widgets.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:piano/widgets/episode_list_item/details.dart';
import 'package:piano/widgets/episode_list_item/menu.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import './thumbnail.dart';

class EpisodeListItem extends StatelessWidget {
  final Episode episode;
  final Podcast podcast;

  const EpisodeListItem({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 0, bottom: 10, left: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Thumbnail(episode: episode, podcast: podcast),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Details(episode: episode, podcast: podcast),
                      ),
                    ),
                    Menu(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 16),
                  child: Text(
                    episode.summary.replaceAll("\n", " "),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: TWColors.teal.shade700,
                      height: 1.3,
                      letterSpacing: 0.35,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
