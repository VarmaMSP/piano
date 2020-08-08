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

  Stream<List<Subscription>> watchAll() {
    return select(subscriptions)
        .watch()
        .map((rows) => rows.map((row) => row.toModel()).toList());
  }

  Future<void> deleteSubscription(String podcastId) {
    return (delete(subscriptions)
          ..where((tbl) => tbl.podcastId.equals(podcastId)))
        .go();
  }
}
