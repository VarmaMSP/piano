import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';

SubscriptionStore newSubscriptionStore(Api api, Db_ db) {
  return _SubscriptionStoreImpl(api: api, db: db);
}

abstract class SubscriptionStore {
  Future<void> subscribe(Podcast podcast);
  Future<void> unsubscribe(Podcast podcast);
  Future<SubscriptionsFeed> getFeed();
  Stream<SubscriptionsFeed> watchFeed();
  Future<void> updateFeed();
}

class _SubscriptionStoreImpl extends SubscriptionStore {
  final Api api;
  final Db_ db;

  _SubscriptionStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<SubscriptionsFeed> getFeed() {
    // TODO: implement getFeed
    throw UnimplementedError();
  }

  @override
  Future<void> subscribe(Podcast podcast) {
    // TODO: implement subscribe
    throw UnimplementedError();
  }

  @override
  Future<void> unsubscribe(Podcast podcast) {
    // TODO: implement unsubscribe
    throw UnimplementedError();
  }

  @override
  Future<void> updateFeed() {
    // TODO: implement updateFeed
    throw UnimplementedError();
  }

  @override
  Stream<SubscriptionsFeed> watchFeed() {
    // TODO: implement watchFeed
    throw UnimplementedError();
  }
}
