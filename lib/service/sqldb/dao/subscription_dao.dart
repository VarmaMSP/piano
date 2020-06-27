part of '../sqldb.dart';

@UseDao(tables: [Subscriptions, SubscriptionFilters])
class SubscriptionDao extends DatabaseAccessor<SqlDb>
    with _$SubscriptionDaoMixin {
  SubscriptionDao(SqlDb db) : super(db);

  Future<void> subscribePodcast(String podcastId) {
    return into(subscriptions).insert(
      SubscriptionRow(podcastId: podcastId),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> unsubscribePodcast(String podcastId) {
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

  Future<void> watchSubscriptions(String tagId) async {}
}
