part of '../db.dart';

@UseDao(tables: [Subscriptions, SubscriptionFilters])
class SubscriptionDao extends DatabaseAccessor<SqlDb>
    with _$SubscriptionDaoMixin {
  SubscriptionDao(SqlDb db) : super(db);

  Future<void> saveSubscription(Subscription subscription) {
    return into(subscriptions).insert(
      subscriptionRowFromModel(subscription),
      mode: InsertMode.insertOrReplace,
    );
  }

  Stream<Subscription> watchByPodcast(String podcastId) {
    return (select(subscriptions)
          ..where((tbl) => tbl.podcastId.equals(podcastId)))
        .watchSingle()
        .map((row) => row?.toModel());
  }

  Future<void> deleteSubscription(String podcastId) {
    return (delete(subscriptions)
          ..where((tbl) => tbl.podcastId.equals(podcastId)))
        .go();
  }
}
