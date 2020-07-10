part of '../db.dart';

@DataClassName('SubscriptionRow')
class Subscriptions extends Table {
  TextColumn get podcastId =>
      text().customConstraint('REFERENCES podcasts(id)')();
  DateTimeColumn get updatedAt => dateTime()();
  // TextColumn get filterId => text()
  //     .nullable()
  //     .customConstraint('NULL REFERENCES subscription_filters(id)')();

  @override
  Set<Column> get primaryKey => {podcastId};
}

SubscriptionRow subscriptionRowFromModel(Subscription model) {
  return SubscriptionRow(
    podcastId: model.podcastId,
    updatedAt: model.updatedAt ?? DateTime.now(),
  );
}

extension SubscriptionRowExtension on SubscriptionRow {
  Subscription toModel() {
    return Subscription(
      podcastId: podcastId,
      updatedAt: updatedAt,
    );
  }
}
