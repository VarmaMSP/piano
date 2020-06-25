import 'podcast.dart';

class Subscription {
  final Podcast podcast;
  final SubscriptionFilter filter;

  Subscription(this.podcast, this.filter);
}

class SubscriptionFilter {
  final String id;
  final String name;

  SubscriptionFilter({this.id, this.name});
}
