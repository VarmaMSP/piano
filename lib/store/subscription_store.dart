// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/alarm_service/alarm_service.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

SubscriptionStore newSubscriptionStore(
  Api api,
  Db db, [
  AlarmService alarmService,
]) {
  return _SubscriptionStoreImpl(
    api: api,
    db: db,
    alarmService: alarmService,
  );
}

abstract class SubscriptionStore {
  Future<void> subscribe(Podcast podcast);
  Future<void> unsubscribe(Podcast podcast);
  Stream<Subscription> watchByPodcast(String podcastId);
}

class _SubscriptionStoreImpl extends SubscriptionStore {
  final Api api;
  final Db db;
  final AlarmService alarmService;

  _SubscriptionStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
  });

  @override
  Future<void> subscribe(Podcast podcast) async {
    await api.subscription.subscribe(podcast.id);
    await db.transaction(() async {
      await db.subscriptionDao.saveSubscription(
        Subscription(podcastId: podcast.id),
      );
      await db.taskDao.saveTask(
        Task.init(
          taskType: TaskType.cachePodcast(
            podcastId: podcast.id,
            podcastUrlParam: podcast.urlParam,
          ),
        ),
      );
    });
    await alarmService?.scheduleTaskRunner();
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
