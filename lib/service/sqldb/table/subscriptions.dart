part of '../sqldb.dart';

@DataClassName('SubscriptionRow')
class Subscriptions extends Table {
  TextColumn get podcastId =>
      text().customConstraint('REFERENCES podcasts(id)')();
  TextColumn get filterId =>
      text().customConstraint('REFERENCES subscription_filters(id)')();

  @override
  Set<Column> get primaryKey => {podcastId};
}

SubscriptionRow subscriptionRowFromModel(Subscription model) {
  return SubscriptionRow(
    filterId: model.filter.id,
    podcastId: model.podcast.id,
  );
}
