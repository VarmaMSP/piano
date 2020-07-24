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
  Future<void> refresh();
  Future<void> subscribe(Podcast podcast);
  Future<void> unsubscribe(Podcast podcast);
  Stream<Subscription> watchByPodcast(String podcastId);
  Stream<List<Podcast>> watchSubscribedPodcasts();
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
  Future<void> refresh() async {
    final page = await api.subscription.getPage();
    final podcasts = page.item1;
    final episodes = page.item2;

    await db.transaction(() async {
      await db.podcastDao.savePodcasts(podcasts);
      await db.episodeDao.saveEpisodes(episodes);
      await db.subscriptionDao.saveSubscriptions(
        podcasts.map((p) => Subscription(podcastId: p.id)).toList(),
      );
      await Future.wait(
        podcasts
            .map(
              (p) => db.taskDao.saveTask(
                Task.mediumPriority(
                  taskType: TaskType.cachePodcast(
                    podcastId: p.id,
                    podcastUrlParam: p.urlParam,
                  ),
                ),
              ),
            )
            .toList(),
      );
    });
    await alarmService?.scheduleTaskRunner();
  }

  @override
  Future<void> subscribe(Podcast podcast) async {
    await api.subscription.subscribe(podcast.id);
    await db.transaction(() async {
      await db.subscriptionDao.saveSubscriptions(
        [Subscription(podcastId: podcast.id)],
      );
      await db.taskDao.saveTask(
        Task.mediumPriority(
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

  @override
  Stream<List<Podcast>> watchSubscribedPodcasts() {
    refresh();
    return db.podcastDao.watchSubscribedPodcasts();
  }
}
