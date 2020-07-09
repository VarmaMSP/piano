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
