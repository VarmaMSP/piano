import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/widgets/screen/layout.dart';
import 'package:phenopod/widgets/screen/loading_layout.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import 'widgets/about_tab.dart';
import 'widgets/episodes_tab.dart';
import 'widgets/podcast_header_delegate.dart';
import 'podcast_screen_bloc.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({
    Key key,
    @required this.urlParam,
  }) : super(key: key);

  final String urlParam;

  @override
  _PodcastScreenState createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PodcastScreenBloc _podcastScreenBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _podcastScreenBloc = PodcastScreenBloc(
      urlParam: widget.urlParam,
      podcastActionsBloc: Provider.of<PodcastActionsBloc>(
        context,
        listen: false,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _podcastScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Tuple3<Podcast, List<Episode>, bool>>(
      stream: Rx.combineLatest3<Podcast, List<Episode>, bool,
          Tuple3<Podcast, List<Episode>, bool>>(
        _podcastScreenBloc.podcast,
        _podcastScreenBloc.episodes,
        _podcastScreenBloc.receivedAllEpisodes,
        (a, b, c) => Tuple3(a, b, c),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingLayout(pageType: PageType.normal);
        }

        return ScreenLayout(
          header: PodcastHeaderDelegate(
            podcast: snapshot.data.item1,
            tabController: _tabController,
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              EpisodesTab(
                key: const PageStorageKey<String>('   Episodes   '),
                podcast: snapshot.data.item1,
                episodes: snapshot.data.item2,
                receivedAll: snapshot.data.item3,
                loadMore: _podcastScreenBloc.loadMoreEpisodes,
              ),
              AboutTab(
                key: const PageStorageKey<String>('   About   '),
                podcast: snapshot.data.item1,
              ),
            ],
          ),
        );
      },
    );
  }
}
