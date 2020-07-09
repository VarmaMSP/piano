import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart' hide Podcast;
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/hook/use_value.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/episode_list_item/episode_list_item.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'subscriptions_screen_bloc.dart';

class SubscriptionsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final subscriptionsScreenBloc = useValue<SubscriptionsScreenBloc>(
      create: (context) => SubscriptionsScreenBloc(
        store: Provider.of<Store>(context),
        podcastActionsBloc: Provider.of<PodcastActionsBloc>(context),
      ),
      dispose: (_, value) => value.dispose(),
    );

    return StreamBuilder<SubscriptionsScreenData>(
      stream: subscriptionsScreenBloc.screenData,
      builder: (context, snapshot) {
        return CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 2,
              backgroundColor: Colors.white,
              title: Text(
                'Phenopod',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.purple.shade800,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 23,
                    color: TWColors.gray.shade700,
                  ),
                  onPressed: () => Navigator.of(context, rootNavigator: true)
                      .pushNamed('/search'),
                ),
              ],
            ),
            if (snapshot.hasData) ...[
              _buildPodcasts(context, snapshot.data),
              _buildAnimatedEpisodeList(
                snapshot.data.podcastById,
                snapshot.data.episodes.length <= 30
                    ? snapshot.data.episodes
                    : snapshot.data.episodes.sublist(0, 30),
              ),
              _buildEpisodeList(
                snapshot.data.podcastById,
                snapshot.data.episodes.length <= 30
                    ? []
                    : snapshot.data.episodes.sublist(30),
                snapshot.data.receivedAllEpisodes,
                subscriptionsScreenBloc.loadMoreEpisodes,
              ),
            ],
          ],
        );
      },
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
    void Function() loadMoreEpisodes,
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
                        .navigateTo(Screen.podcast(urlParam: podcast.urlParam)),
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
