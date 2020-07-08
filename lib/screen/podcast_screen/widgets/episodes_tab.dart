import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/widgets/episode_list_item/episode_list_item.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class EpisodesTab extends StatelessWidget {
  const EpisodesTab({
    Key key,
    @required this.screenData,
    @required this.loadMoreEpisodes,
  }) : super(key: key);

  final PodcastScreenData screenData;
  final void Function() loadMoreEpisodes;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        color: Colors.white,
        child: CustomScrollView(
          key: const PageStorageKey('episodes'),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 15),
              sliver: _buildAnimatedEpisodeList(
                screenData.podcast,
                screenData.episodes.length <= 15
                    ? screenData.episodes
                    : screenData.episodes.sublist(0, 15),
              ),
            ),
            _buildEpisodeList(
              screenData.podcast,
              screenData.episodes.length <= 15
                  ? []
                  : screenData.episodes.sublist(15),
              screenData.receivedAllEpisodes,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedEpisodeList(
    Podcast podcast,
    List<Episode> episodes,
  ) {
    return SliverImplicitlyAnimatedList<Episode>(
      items: episodes,
      areItemsTheSame: (a, b) => a.id == b.id,
      itemBuilder: (context, animation, episode, index) => SizeFadeTransition(
        sizeFraction: 0.7,
        curve: Curves.easeInOut,
        animation: animation,
        child: EpisodeListItem(
          episode: episode,
          podcast: podcast,
        ),
      ),
    );
  }

  Widget _buildEpisodeList(
    Podcast podcast,
    List<Episode> episodes,
    bool receivedAllEpisodes,
  ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < episodes.length) {
            return EpisodeListItem(
              episode: episodes[index],
              podcast: podcast,
            );
          }
          Future.delayed(Duration(milliseconds: 100), loadMoreEpisodes);
          return _buildLoadingIndicator();
        },
        childCount: receivedAllEpisodes ? episodes.length : episodes.length + 1,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 75,
      padding: EdgeInsets.only(bottom: 20),
      child: Center(
        child: Container(
          constraints: BoxConstraints.expand(
            width: 25,
            height: 25,
          ),
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(
              TWColors.blue.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
