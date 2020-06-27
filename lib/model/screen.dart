import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'podcast.dart';
import 'episode.dart';

part 'screen.g.dart';

@CopyWith()
class PodcastScreenData extends Equatable {
  final Podcast podcast;
  final List<Episode> episodes;
  final bool isSubscribed;
  final bool receivedAllEpisodes;

  PodcastScreenData({
    this.podcast,
    this.episodes,
    this.isSubscribed,
    this.receivedAllEpisodes,
  });

  @override
  List<Object> get props => [podcast, isSubscribed];
}

@CopyWith()
class SubscriptionsScreenData extends Equatable {
  final List<Episode> episodes;
  final Map<String, Podcast> podcastById;

  SubscriptionsScreenData({this.podcastById, this.episodes});

  @override
  List<Object> get props => [podcastById, episodes];
}
