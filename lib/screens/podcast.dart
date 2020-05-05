import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/podcast/podcast_bloc.dart';
import 'package:piano/utils/request.dart';
import 'package:piano/widgets/episode_list_item/episode_list_item.dart';
import 'package:piano/widgets/podcast_header/podcast_header.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:transparent_image/transparent_image.dart';

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
  ScrollController _appBarScrollController;

  @override
  void initState() {
    super.initState();
    _podcastBloc = PodcastBloc(
      request: Request(),
      urlParam: 'darknet-diaries-b8XXmb',
    )..add(Load());
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController()..addListener(_onScroll);
    _appBarScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastBloc, PodcastState>(
      bloc: _podcastBloc,
      builder: (context, state) {
        print(state);
        if (state is PodcastInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PodcastError) {
          return Center(
            child: Text(state.errMsg),
          );
        }

        if (state is PodcastLoaded && state.episodes.isEmpty) {
          return Center(
            child: Text('no episodes'),
          );
        }

        final s = (state as PodcastLoaded);
        return NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, _) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.white,
                  elevation: 0.6,
                  forceElevated: true,
                  // title: Transform.translate(
                  //   offset: Offset(-10, 0),
                  //   child: Text(
                  //     s.podcast.title,
                  //     style: TextStyle(
                  //       color: TWColors.gray.shade800,
                  //       fontSize: 16,
                  //       letterSpacing: 0.35,
                  //     ),
                  //   ),
                  // ),
                  leading: Transform.translate(
                    offset: Offset(-4, 0),
                    child: Icon(
                      Icons.arrow_back,
                      size: 24.0,
                      color: TWColors.gray.shade700,
                    ),
                  ),

                  // actions: <Widget>[
                  //   Padding(
                  //     padding: const EdgeInsets.only(right: 20.0),
                  //     child: Icon(
                  //       Icons.search,
                  //       size: 24.0,
                  //       color: TWColors.gray.shade700,
                  //     ),
                  //   ),
                  //   Padding(
                  //     padding: const EdgeInsets.only(right: 16.0),
                  //     child: Icon(
                  //       Icons.share,
                  //       size: 22.0,
                  //       color: TWColors.gray.shade700,
                  //     ),
                  //   ),
                  // ],
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 58.0),
                        child: PodcastHeader(
                          podcast: s.podcast,
                        ),
                      ),
                    ),
                  ),
                  expandedHeight: 210,
                  bottom: PreferredSize(
                    preferredSize: Size(double.infinity, 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Transform.translate(
                        offset: Offset(-4, 0),
                        child: Container(
                          height: 40,
                          child: TabBar(
                            isScrollable: true,
                            indicatorColor: TWColors.green.shade900,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorWeight: 2.8,
                            labelColor: TWColors.teal.shade900,
                            labelStyle: TextStyle(
                              fontSize: 15,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: _tabController,
                            tabs: <Widget>[
                              Tab(text: ' Episodes '),
                              Tab(text: ' About '),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Builder(builder: (context) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index < s.episodes.length) {
                            return EpisodeListItem(
                              episode: s.episodes[index],
                              podcast: s.podcast,
                            );
                          }

                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 25.0),
                            child: Center(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.black87),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: s.loadedAll
                            ? s.episodes.length
                            : s.episodes.length + 1,
                      ),
                    ),
                  ],
                );
              }),
              Container(),
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
    _appBarScrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 200.0) {
      _podcastBloc.add(Load());
    }
  }
}
