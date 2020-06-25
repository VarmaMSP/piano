import 'package:flutter/material.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/widgets/episode_list_item/episode_list_item.dart';
// import 'package:phenopod/widgets/screen/layout.dart';
import 'package:phenopod/widgets/screen/loading_layout.dart';
import 'package:provider/provider.dart';

import 'subscriptions_screen_bloc.dart';
// import 'widgets/episode_list.dart';
// import 'widgets/subscriptions_header_delegate.dart';

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
        if (!snapshot.hasData) {
          return LoadingLayout(pageType: PageType.normal);
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              leading: Text(
                'Subscriptions',
                style: TextStyle(color: Colors.black87),
              ),
              elevation: 2,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < snapshot.data.episodes.length) {
                    return EpisodeListItem(
                      episode: snapshot.data.episodes[index],
                      podcast: snapshot.data
                          .podcastById[snapshot.data.episodes[index].podcastId],
                    );
                  }

                  return null;
                },
                childCount: snapshot.data.episodes.length,
              ),
            )
          ],
        );
      },
    );
  }
}
