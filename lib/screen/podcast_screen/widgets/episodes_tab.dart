import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/screen/podcast_screen/podcast_screen_bloc.dart';
import 'package:phenopod/widgets/episode_list_item/episode_list_item.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class EpisodesTab extends StatelessWidget {
  const EpisodesTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final podcastScreenBloc = Provider.of<PodcastScreenBloc>(context);

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        color: Colors.white,
        child: StreamBuilder<Tuple2<Podcast, List<Episode>>>(
          stream: Rx.combineLatest2<Podcast, List<Episode>,
              Tuple2<Podcast, List<Episode>>>(
            podcastScreenBloc.podcast,
            podcastScreenBloc.episodes,
            (a, b) => Tuple2(a, b),
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data.item2 == null) {
              return Container();
            }

            final podcast = snapshot.data?.item1;
            final episodes = podcast != null ? snapshot.data?.item2 ?? [] : [];

            return CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.only(top: 95),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < episodes.length) {
                          return EpisodeListItem(
                            episode: episodes[index],
                            podcast: podcast,
                          );
                        }
                        return null;
                      },
                      childCount: episodes.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
