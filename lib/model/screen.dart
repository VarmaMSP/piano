import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'episode.dart';
import 'podcast.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

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
class SubscriptionScreenData {
  final List<Podcast> subscriptions;
  final List<Episode> episodes;
  final Map<String, Podcast> subscriptionById;

  SubscriptionScreenData({this.subscriptions, this.episodes})
      : subscriptionById = {for (var i in subscriptions) i.id: i};
}
