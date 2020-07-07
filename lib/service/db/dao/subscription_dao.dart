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
        .map((row) => row != null ? Subscription() : null);
  }

  Future<void> deleteSubscription(String podcastId) {
    return (delete(subscriptions)
          ..where((tbl) => tbl.podcastId.equals(podcastId)))
        .go();
  }

  Future<bool> isSubscribed(String podcastId) async {
    final row = await (select(subscriptions)
          ..where((tbl) => tbl.podcastId.equals(podcastId)))
        .getSingle();
    return row != null;
  }

  Future<void> watchTags() async {}
}
