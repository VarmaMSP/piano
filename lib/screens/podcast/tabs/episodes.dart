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
          SliverList(
            key: key,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Container(height: 95);
                }

                if (index >= 1 && index <= episodes.length) {
                  return EpisodeListItem(
                    episode: episodes[index - 1],
                    podcast: podcast,
                  );
                }

                loadMore();
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        TWColors.gray.shade800,
                      ),
                    ),
                  ),
                );
              },
              childCount:
                  receivedAll ? episodes.length + 1 : episodes.length + 2,
            ),
          ),
        ],
      ),
    );
  }
}
