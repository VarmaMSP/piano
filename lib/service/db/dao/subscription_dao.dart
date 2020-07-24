part of '../db.dart';

@UseDao(tables: [Subscriptions, SubscriptionFilters])
class SubscriptionDao extends DatabaseAccessor<SqlDb>
    with _$SubscriptionDaoMixin {
  SubscriptionDao(SqlDb db) : super(db);

  Future<void> saveSubscriptions(List<Subscription> subscriptionList) async {
    if (subscriptionList.isNotEmpty) {
      await batch(
        (b) => b.insertAll(
          subscriptions,
          subscriptionList.map((s) => subscriptionRowFromModel(s)).toList(),
          mode: InsertMode.insertOrIgnore,
        ),
      );
    }
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
