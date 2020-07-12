import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart' hide Podcast;
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/episode_list_item/episode_list_item.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SubscriptionsFeed extends StatelessWidget {
  const SubscriptionsFeed({
    Key key,
    @required this.screenData,
    @required this.loadMoreEpisodes,
  }) : super(key: key);

  final SubscriptionsScreenData screenData;
  final void Function() loadMoreEpisodes;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildPodcasts(context, screenData),
        _buildAnimatedEpisodeList(
          screenData.podcastById,
          screenData.episodes.length <= 30
              ? screenData.episodes
              : screenData.episodes.sublist(0, 30),
        ),
        _buildEpisodeList(
          screenData.podcastById,
          screenData.episodes.length <= 30
              ? []
              : screenData.episodes.sublist(30),
          screenData.receivedAllEpisodes,
        ),
      ],
    );
  }

  Widget _buildAnimatedEpisodeList(
    Map<String, Podcast> podcastById,
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
          podcast: podcastById[episode.podcastId],
        ),
      ),
    );
  }

  Widget _buildEpisodeList(
    Map<String, Podcast> podcastById,
    List<Episode> episodes,
    bool receivedAllEpisodes,
  ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < episodes.length) {
            return EpisodeListItem(
              episode: episodes[index],
              podcast: podcastById[episodes[index].podcastId],
            );
          }
          loadMoreEpisodes();
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

  Widget _buildPodcasts(
    BuildContext context,
    SubscriptionsScreenData screenData,
  ) {
    final thumbnailSize = 75.0;
    final borderRadius = 8.0;

    return SliverToBoxAdapter(
      child: Container(
        width: getScreenWidth(context),
        height: thumbnailSize,
        margin: EdgeInsets.only(top: 10, bottom: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(width: 18);
            }

            if (index <= screenData.podcasts.length) {
              final podcast = screenData.podcasts[index - 1];
              return GestureDetector(
                onTap: () =>
                    Provider.of<AppNavigationBloc>(context, listen: false)
                        .pushScreen(Screen.podcast(urlParam: podcast.urlParam)),
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Container(
                    height: thumbnailSize,
                    width: thumbnailSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius),
                      ),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 0.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: CachedNetworkImage(
                        imageUrl: '$thumbnailUrl/${podcast.urlParam}.jpg',
                        fit: BoxFit.fill,
                        height: thumbnailSize,
                        width: thumbnailSize,
                        placeholder: (BuildContext context, String url) =>
                            Container(
                          height: thumbnailSize,
                          width: thumbnailSize,
                          color: TWColors.gray.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
