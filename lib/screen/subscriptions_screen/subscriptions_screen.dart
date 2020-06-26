import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
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
    return StreamBuilder<SubscriptionsScreenData>(
      stream: _subscriptionsScreenBloc.screenData,
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
              SliverImplicitlyAnimatedList<Tuple2<Episode, Podcast>>(
                items: [
                  for (var e in snapshot.data.episodes)
                    Tuple2(e, snapshot.data.podcastById[e.podcastId])
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
          ],
        );
      },
    );
  }
}
