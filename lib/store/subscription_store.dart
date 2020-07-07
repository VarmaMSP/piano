import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/db/db.dart';

SubscriptionStore newSubscriptionStore(Api api, Db db) {
  return _SubscriptionStoreImpl(api: api, db: db);
}

abstract class SubscriptionStore {
  Future<void> subscribe(Podcast podcast);
  Future<void> unsubscribe(Podcast podcast);
  Future<void> watchSubscribedPodcasts();
  Stream<Subscription> watchByPodcast(String podcastId);
}

class _SubscriptionStoreImpl extends SubscriptionStore {
  final Api api;
  final Db db;

  _SubscriptionStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<void> subscribe(Podcast podcast) {
    throw UnimplementedError();
  }

  @override
  Future<void> unsubscribe(Podcast podcast) {
    throw UnimplementedError();
  }

  @override
  Future<void> watchSubscribedPodcasts() {
    throw UnimplementedError();
  }

  @override
  Stream<Subscription> watchByPodcast(String podcastId) {
    return db.subscriptionDao.watchByPodcast(podcastId);
  }
}
