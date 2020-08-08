// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:rxdart/subjects.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/alarm_service/alarm_service.dart';
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/db/db.dart';

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
  Subscription getByPodcast(String podcastId);
  Stream<Subscription> watchByPodcast(String podcastId);
  Stream<List<Podcast>> watchSubscribedPodcasts();
}

class _SubscriptionStoreImpl extends SubscriptionStore {
  final Api api;
  final Db db;
  final AlarmService alarmService;

  /// Keep subscriptions table in memory
  final BehaviorSubject<Map<String, Subscription>> _byPodcastId =
      BehaviorSubject<Map<String, Subscription>>.seeded({});

  _SubscriptionStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
  }) {
    db.subscriptionDao.watchAll().listen((subscriptions) {
      _byPodcastId.add({for (var sub in subscriptions) sub.podcastId: sub});
    });
  }

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
  Subscription getByPodcast(String podcastId) {
    return _byPodcastId.value[podcastId];
  }

  @override
  Stream<Subscription> watchByPodcast(String podcastId) {
    return _byPodcastId.map((byPodcastId) => byPodcastId[podcastId]);
  }

  @override
  Stream<List<Podcast>> watchSubscribedPodcasts() {
    refresh();
    return db.podcastDao.watchSubscribedPodcasts();
  }
}
