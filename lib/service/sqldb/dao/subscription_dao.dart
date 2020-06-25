part of '../sqldb.dart';

@UseDao(tables: [])
class SubscriptionDao extends DatabaseAccessor<SqlDb>
    with _$SubscriptionDaoMixin {
  SubscriptionDao(SqlDb db) : super(db);

  Future<void> saveSubscription(Subscription subscription) async {}

  Future<void> watchTags() async {}

  Future<void> watchSubscriptions(String tagId) async {}
}
