import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/widgets/episode_list_item/episode_list_item.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class EpisodesList extends StatelessWidget {
  const EpisodesList({
    Key key,
    @required this.podcastById,
    @required this.episodes,
    @required this.receivedAll,
    @required this.loadMore,
  }) : super(key: key);

  final Map<String, Podcast> podcastById;
  final List<Episode> episodes;
  final bool receivedAll;
  final Function loadMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 50),
            sliver: SliverList(
              key: key,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index < episodes.length) {
                    return EpisodeListItem(
                      episode: episodes[index],
                      podcast: podcastById[episodes[index].podcastId],
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