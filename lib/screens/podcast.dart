import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/podcast/podcast_bloc.dart';
import 'package:piano/utils/request.dart';
import 'package:piano/widgets/episode_list_item/episode_list_item.dart';
import 'package:piano/widgets/podcast_header/podcast_header.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PodcastPage extends StatefulWidget {
  const PodcastPage({Key key}) : super(key: key);

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PodcastBloc _podcastBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _podcastBloc = PodcastBloc(
      request: Request(),
      urlParam: 'darknet-diaries-b8XXmb',
    )..add(Load());
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
        return CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: true,
              backgroundColor: Colors.white,
              elevation: 1.0,
              leading: Icon(
                Icons.arrow_back,
                size: 26.0,
                color: TWColors.gray.shade700,
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                    color: TWColors.gray.shade700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Icon(
                    Icons.share,
                    size: 24.0,
                    color: TWColors.gray.shade700,
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return PodcastHeader(podcast: s.podcast);
                  }

                  if (index >= 1 && index <= s.episodes.length) {
                    return EpisodeListItem(
                      episode: s.episodes[index - 1],
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
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.black87),
                        ),
                      ),
                    ),
                  );
                },
                childCount:
                    s.loadedAll ? s.episodes.length + 1 : s.episodes.length + 2,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _podcastBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _podcastBloc.add(Load());
    }
  }
}
