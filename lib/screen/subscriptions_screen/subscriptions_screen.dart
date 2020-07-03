import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart' hide Podcast;
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/episode_list_item/episode_list_item.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tuple/tuple.dart';

import 'subscriptions_screen_bloc.dart';

class SubscriptionsScreen extends StatefulWidget {
  SubscriptionsScreen({Key key}) : super(key: key);

  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  SubscriptionsScreenBloc _subscriptionsScreenBloc;

  @override
  void initState() {
    super.initState();
    _subscriptionsScreenBloc = SubscriptionsScreenBloc(
      store: Provider.of<Store>(context, listen: false),
      podcastActionsBloc: Provider.of<PodcastActionsBloc>(
        context,
        listen: false,
      ),
    );
  }

  @override
  void dispose() {
    _subscriptionsScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SubscriptionsFeed>(
      stream: _subscriptionsScreenBloc.feed,
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
            if (!snapshot.hasData)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  color: Colors.white,
                  constraints: BoxConstraints.expand(),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            if (snapshot.hasData)
              SliverToBoxAdapter(
                child: Container(
                  width: getScreenWidth(context),
                  height: 70,
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final podcastIds =
                          snapshot.data.subscriptionById.keys.toList();
                      final thumbnailSize = 70.0;
                      final borderRadius = 8.0;

                      if (index == 0) {
                        return Container(width: 18);
                      }

                      if (index <= podcastIds.length) {
                        final podcast = snapshot
                            .data.subscriptionById[podcastIds[index - 1]];
                        return GestureDetector(
                          onTap: () {
                            final appNavigationBloc =
                                Provider.of<AppNavigationBloc>(context,
                                    listen: false);
                            appNavigationBloc.navigateTo(
                                Screen.podcast(urlParam: podcast.urlParam));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Container(
                              height: thumbnailSize,
                              width: thumbnailSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(borderRadius)),
                                border: Border.all(
                                    color: Colors.grey.shade400, width: 0.5),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '$thumbnailUrl/${podcast.urlParam}.jpg',
                                  fit: BoxFit.fill,
                                  height: thumbnailSize,
                                  width: thumbnailSize,
                                  placeholder:
                                      (BuildContext context, String url) =>
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
              ),
            if (snapshot.hasData)
              SliverImplicitlyAnimatedList<Tuple2<Episode, Podcast>>(
                spawnIsolate: true,
                items: [
                  for (var e in snapshot.data.episodes)
                    Tuple2(e, snapshot.data.subscriptionById[e.podcastId])
                ],
                areItemsTheSame: (a, b) => a.item1.id == b.item1.id,
                itemBuilder: (context, animation, item, _) {
                  return SizeFadeTransition(
                    sizeFraction: 0.7,
                    curve: Curves.easeInOut,
                    animation: animation,
                    child: EpisodeListItem(
                      episode: item.item1,
                      podcast: item.item2,
                    ),
                  );
                },
              ),
            // SliverToBoxAdapter(child: AppSnackBar()),
          ],
        );
      },
    );
  }
}
