// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/utils/utils.dart';

PodcastStore newPodcastStore(Api api, Db db) {
  return _PodcastStoreImpl(api: api, db: db);
}

abstract class PodcastStore {
  Stream<Podcast> watchByUrlParam(String urlParam);
  Stream<List<Podcast>> watchSubscribed();
}

class _PodcastStoreImpl extends PodcastStore {
  final Api api;
  final Db db;

  _PodcastStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Stream<Podcast> watchByUrlParam(String urlParam) {
    // ignore: unawaited_futures
    api.podcast.getPage(urlParam: urlParam).then((value) async {
      final podcast = value.item1;
      final episodes = value.item2;

      await db.transaction(() async {
        await db.podcastDao.upsert(podcast);
        await db.episodeDao.saveEpisodes(episodes);

        !podcast.isSubscribed
            ? await db.subscriptionDao.deleteSubscription(podcast.id)
            : await db.subscriptionDao.saveSubscription(
                Subscription(podcastId: podcast.id),
              );

        if (episodes.length < 15) {
          await db.podcastDao.updateCacheDetails(
            podcast.id,
            cachedAllEpisodes: true,
          );
        }
      });
    });

    return db.podcastDao.watchPodcast(getIdFromUrlParam(urlParam));
  }

  @override
  Stream<List<Podcast>> watchSubscribed() {
    return db.podcastDao.watchSubscribedPodcasts();
  }
}
