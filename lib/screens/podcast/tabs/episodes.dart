import 'package:flutter/material.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:piano/widgets/episode_list_item/episode_list_item.dart';

class EpisodesTab extends StatelessWidget {
  const EpisodesTab({
    Key key,
    @required this.podcast,
    @required this.episodes,
  }) : super(key: key);

  final Podcast podcast;
  final List<Episode> episodes;

  @override
  Widget build(BuildContext context) {
    final overlapInjector = SliverOverlapInjector(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
        context,
      ),
    );

    return CustomScrollView(
      slivers: <Widget>[
        overlapInjector,
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return EpisodeListItem(
                episode: episodes[index],
                podcast: podcast,
              );
            },
            childCount: episodes.length,
          ),
        ),
      ],
    );
  }
}
