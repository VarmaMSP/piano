import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/podcast/podcast_bloc.dart';
import 'package:piano/utils/request.dart';
import 'package:piano/widgets/episode_list_item/episode_list_item.dart';

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
      urlParam:
          'sean-carrolls-mindscape-science-society-philosophy-culture-arts-and-ideas-ejYpWd',
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
        return ListView.builder(
          itemBuilder: (context, index) {
            return index < s.episodes.length
                ? EpisodeListItem(
                    episode: s.episodes[index],
                    podcast: s.podcast,
                  )
                : Container(
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
          itemCount: s.loadedAll ? s.episodes.length : s.episodes.length + 1,
          controller: _scrollController,
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
