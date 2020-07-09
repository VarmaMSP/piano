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
  Future<void> subscribe(Podcast podcast) async {
    await api.subscription.subscribe(podcast.id);
    await db.subscriptionDao
        .saveSubscription(Subscription(podcastId: podcast.id));
  }

  @override
  Future<void> unsubscribe(Podcast podcast) async {
    await api.subscription.unsubscribe(podcast.id);
    await db.subscriptionDao.deleteSubscription(podcast.id);
  }

  @override
  Stream<Subscription> watchByPodcast(String podcastId) {
    return db.subscriptionDao.watchByPodcast(podcastId);
  }
}
