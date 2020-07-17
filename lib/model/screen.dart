// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'episode.dart';
import 'podcast.dart';

part 'screen.g.dart';

@CopyWith()
class PodcastScreenData extends Equatable {
  final Podcast podcast;
  final List<Episode> episodes;
  final bool isSubscribed;
  final bool receivedAllEpisodes;

  PodcastScreenData({
    @required this.podcast,
    @required this.episodes,
    @required this.isSubscribed,
    @required this.receivedAllEpisodes,
  });

  @override
  List<Object> get props => [
        podcast,
        episodes,
        isSubscribed,
        receivedAllEpisodes,
      ];
}

@CopyWith()
class SubscriptionsScreenData extends Equatable {
  final List<Podcast> podcasts;
  final List<Episode> episodes;
  final bool receivedAllEpisodes;
  final Map<String, Podcast> podcastById;

  SubscriptionsScreenData({
    @required this.podcasts,
    @required this.episodes,
    @required this.receivedAllEpisodes,
  }) : podcastById = {for (var i in podcasts) i.id: i};

  @override
  List<Object> get props => [podcasts, episodes];
}
