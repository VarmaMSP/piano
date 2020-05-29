import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phenopod/blocs/podcast/podcast_bloc.dart';
import './widgets/about_tab.dart';
import './widgets/episodes_tab.dart';
import './widgets/header.dart';

class PodcastView extends StatefulWidget {
  const PodcastView({
    Key key,
    @required this.state,
    @required this.loadMoreEpisodes,
  }) : super(key: key);

  final PodcastLoaded state;
  final void Function() loadMoreEpisodes;

  @override
  _PodcastViewState createState() => _PodcastViewState();
}

class _PodcastViewState extends State<PodcastView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, _) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
              context,
            ),
            sliver: SliverPersistentHeader(
              pinned: true,
              delegate: PodcastHeaderDelegate(
                podcast: widget.state.podcast,
                tabController: _tabController,
              ),
            ),
          )
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          EpisodesTab(
            key: const PageStorageKey<String>('   Episodes   '),
            podcast: widget.state.podcast,
            episodes: widget.state.episodes,
            receivedAll: widget.state.loadedAll,
            loadMore: widget.loadMoreEpisodes,
          ),
          AboutTab(
            key: const PageStorageKey<String>('   About   '),
            podcast: widget.state.podcast,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
