import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/podcast/podcast_bloc.dart';
import 'package:piano/screens/loading.dart';
import 'package:piano/screens/podcast/tabs/about.dart';
import 'package:piano/screens/podcast/tabs/episodes.dart';
import 'package:piano/widgets/app_bar/podcast.dart';
import 'package:piano/utils/request.dart';

class PodcastPage extends StatefulWidget {
  const PodcastPage({Key key}) : super(key: key);

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage>
    with TickerProviderStateMixin {
  PodcastBloc _podcastBloc;
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    final request = Request();
    final urlParam = 'heavyweight-e79vOb';

    super.initState();
    _podcastBloc = PodcastBloc(request: request, urlParam: urlParam);
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();

    _podcastBloc.add(Load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastBloc, PodcastState>(
      bloc: _podcastBloc,
      builder: (context, state) {
        if (state is PodcastInitial) {
          return LoadingPage();
        }

        if (state is PodcastError) {
          return Center(
            child: Text(state.errMsg),
          );
        }

        final s = state as PodcastLoaded;
        return NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, _) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                child: PodcastAppBar(
                  podcast: s.podcast,
                  tabController: _tabController,
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              EpisodesTab(
                key: PageStorageKey<String>('  Episodes  '),
                podcast: s.podcast,
                episodes: s.episodes,
                receivedAll: s.loadedAll,
                loadMore: () => _podcastBloc.add(Load()),
              ),
              AboutTab(
                key: PageStorageKey<String>('  About  '),
                podcast: s.podcast,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _podcastBloc.close();
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
