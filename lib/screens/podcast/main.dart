import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/blocs/subscription/subscription_bloc.dart';
import 'package:phenopod/widgets/screen/layout.dart';
import 'package:phenopod/widgets/screen/loading_layout.dart';

import 'bloc/podcast_bloc.dart';
import 'widgets/about_tab.dart';
import 'widgets/episodes_tab.dart';
import 'widgets/podcast_header_delegate.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PodcastBloc(
        urlParam: widget.urlParam,
        subscriptionBloc: BlocProvider.of<SubscriptionBloc>(context),
      )..add(Load()),
      child: Builder(builder: _screenBuilder),
    );
  }

  Widget _screenBuilder(BuildContext context) {
    final podcastBloc = BlocProvider.of<PodcastBloc>(context);

    return BlocBuilder<PodcastBloc, PodcastState>(
      bloc: podcastBloc,
      builder: (BuildContext context, PodcastState state) {
        if (state is PodcastInitial) {
          return LoadingLayout(pageType: PageType.normal);
        }

        if (state is PodcastLoaded) {
          return ScreenLayout(
            header: PodcastHeaderDelegate(
              podcast: state.podcast,
              tabController: _tabController,
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                EpisodesTab(
                  key: const PageStorageKey<String>('   Episodes   '),
                  podcast: state.podcast,
                  episodes: state.episodes,
                  receivedAll: state.loadedAll,
                  loadMore: () => podcastBloc.add(Load()),
                ),
                AboutTab(
                  key: const PageStorageKey<String>('   About   '),
                  podcast: state.podcast,
                ),
              ],
            ),
          );
        }

        return null;
      },
    );
  }
}
