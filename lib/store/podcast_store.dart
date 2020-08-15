// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/alarm_service/alarm_service.dart';
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/db/db.dart';
import 'package:phenopod/utils/utils.dart';

PodcastStore newPodcastStore(
  Api api,
  Db db,
  AlarmService alarmService,
  bool lazyQueries,
) {
  return _PodcastStoreImpl(api: api, db: db, alarmService: alarmService);
}

abstract class PodcastStore {
  Future<void> refresh(String urlParam);
  Stream<Podcast> watchById(String id);
  Stream<Podcast> watchByUrlParam(String urlParam);
}

class _PodcastStoreImpl extends PodcastStore {
  final Api api;
  final Db db;
  final AlarmService alarmService;

  _PodcastStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
  });

  @override
  Future<void> refresh(String urlParam) async {
    final data = await api.podcast.getPage(urlParam: urlParam);
    final podcast = data.item1;
    final episodes = data.item2;

    await db.transaction(() async {
      await db.podcastDao.upsert(podcast);
      await db.episodeDao.saveEpisodes(episodes);

      if (episodes.length < 15) {
        await db.podcastDao.updateCacheDetails(
          podcast.id,
          cachedAllEpisodes: true,
        );
      }

      if (podcast.isSubscribed) {
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
      } else {
        await db.subscriptionDao.deleteSubscription(podcast.id);
      }
    });

    if (podcast.isSubscribed) {
      await alarmService?.scheduleTaskRunner();
    }
  }

  @override
  Stream<Podcast> watchById(String id) {
    return db.podcastDao.watchPodcast(id);
  }

  @override
  Stream<Podcast> watchByUrlParam(String urlParam) {
    refresh(urlParam);
    return db.podcastDao.watchPodcast(getIdFromUrlParam(urlParam));
  }
}
