import 'package:equatable/equatable.dart';

import 'episode.dart';
import 'podcast.dart';

class Subscription {
  final String podcastId;
  final SubscriptionFilter filter;

  Subscription({this.podcastId, this.filter});
}

class SubscriptionFilter {
  final String id;
  final String name;

  SubscriptionFilter({this.id, this.name});
}

class SubscriptionsFeed extends Equatable {
  final Map<String, Podcast> subscriptionById;
  final List<Episode> episodes;

  SubscriptionsFeed({this.episodes, List<Podcast> podcasts})
      : subscriptionById = {for (var p in podcasts) p.id: p};

  @override
  List<Object> get props => [episodes, subscriptionById];
}
