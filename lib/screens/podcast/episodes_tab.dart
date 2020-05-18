import 'package:flutter/material.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:piano/widgets/episode_list_item/episode_list_item.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class EpisodesTab extends StatelessWidget {
  const EpisodesTab({
    Key key,
    @required this.podcast,
    @required this.episodes,
    @required this.receivedAll,
    @required this.loadMore,
  }) : super(key: key);

  final Podcast podcast;
  final List<Episode> episodes;
  final bool receivedAll;
  final Function loadMore;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 90),
            sliver: SliverList(
              key: key,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index < episodes.length) {
                    return EpisodeListItem(
                      episode: episodes[index],
                      podcast: podcast,
                    );
                  }

                  loadMore();
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          TWColors.gray.shade800,
                        ),
                      ),
                    ),
                  );
                },
                childCount: receivedAll ? episodes.length : episodes.length + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
