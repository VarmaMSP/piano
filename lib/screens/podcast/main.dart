import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/utils/request.dart';
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
  PodcastBloc _podcastBloc;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _podcastBloc = PodcastBloc(request: Request(), urlParam: widget.urlParam);
    _tabController = TabController(vsync: this, length: 2);
    _podcastBloc.add(Load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastBloc, PodcastState>(
      bloc: _podcastBloc,
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
                  loadMore: () => _podcastBloc.add(Load()),
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

  @override
  void dispose() {
    _podcastBloc.close();
    _tabController.dispose();
    super.dispose();
  }
}
