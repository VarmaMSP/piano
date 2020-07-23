part of 'main.dart';

class Subscription {
  final String podcastId;
  final DateTime updatedAt;

  Subscription({
    @required this.podcastId,
    this.updatedAt,
  });
}

class SubscriptionFilter {
  final String id;
  final String name;
  final DateTime updatedAt;

  SubscriptionFilter({
    @required this.id,
    @required this.name,
    this.updatedAt,
  });
}
