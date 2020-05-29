import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/blocs/podcast/podcast_bloc.dart';
import 'package:phenopod/screens/loading.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/widgets/podcast_view/main.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({
    Key key,
    @required this.urlParam,
  }) : super(key: key);

  final String urlParam;

  @override
  _PodcastScreenState createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  PodcastBloc _podcastBloc;

  @override
  void initState() {
    super.initState();

    _podcastBloc = PodcastBloc(request: Request(), urlParam: widget.urlParam)
      ..add(Load());
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

        return PodcastView(
          state: state,
          loadMoreEpisodes: () => _podcastBloc.add(Load()),
        );
      },
    );

    return scrollable;
  }

  @override
  void dispose() {
    _podcastBloc.close();
    super.dispose();
  }
}
