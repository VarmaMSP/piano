import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/blocs/podcast/podcast_bloc.dart';
import 'package:phenopod/screens/loading.dart';
import 'package:phenopod/utils/request.dart';
import './about_tab.dart';
import './episodes_tab.dart';
import './header.dart';

class PodcastPage extends StatefulWidget {
  const PodcastPage({Key key, @required this.urlParam}) : super(key: key);

  final String urlParam;

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage>
    with SingleTickerProviderStateMixin {
  PodcastBloc _podcastBloc;
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _podcastBloc = PodcastBloc(request: Request(), urlParam: widget.urlParam);
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();

    _podcastBloc.add(Load());
  }

  @override
  Widget build(BuildContext context) {
    final Widget scrollable = BlocBuilder<PodcastBloc, PodcastState>(
      bloc: _podcastBloc,
      builder: (BuildContext context, PodcastState state) {
        if (state is PodcastInitial) {
          return const LoadingPage();
        }

        if (state is PodcastError) {
          return Center(
            child: Text(state.errMsg),
          );
        }

        final s = state as PodcastLoaded;
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
                    podcast: s.podcast,
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
                podcast: s.podcast,
                episodes: s.episodes,
                receivedAll: s.loadedAll,
                loadMore: () => _podcastBloc.add(Load()),
              ),
              AboutTab(
                key: const PageStorageKey<String>('   About   '),
                podcast: s.podcast,
              ),
            ],
          ),
        );
      },
    );

    return scrollable;
  }

  @override
  void dispose() {
    _podcastBloc.close();
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
