import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/utils.dart';

import 'db.dart';

class PodcastDb extends PodcastStore {
  final Db db;
  final PodcastStore baseStore;

  PodcastDb({this.baseStore, this.db});

  @override
  Future<void> save(Podcast podcast) {
    return db.podcastDao.savePodcast(podcast);
  }

  @override
  Future<void> saveScreenData(PodcastScreenData screenData) {
    return db.transaction(() async {
      await db.podcastDao.savePodcast(screenData.podcast);
      await db.episodeDao.saveEpisodes(screenData.episodes);
      await db.subscriptionDao.subscribePodcast(screenData.podcast.id);
    });
  }

  @override
  Stream<PodcastScreenData> watchScreenData(String podcastUrlParam) async* {
    var screenDataDb = await _getScreenData(podcastUrlParam);
    if (screenDataDb != null) {
      yield screenDataDb;
    }

    /// Yield screendata from api if podcast is not cached
    var screenDataApi = await baseStore.watchScreenData(podcastUrlParam).first;
    if (screenDataDb == null) {
      yield screenDataApi;
      return;
    }

    /// Yield screenData after persisting any updates
    if (await _updateScreenData(screenDataDb, screenDataApi)) {
      yield (await _getScreenData(podcastUrlParam));
    }
  }

  @override
  Future<void> deleteScreenData(String podcastId) {
    return db.transaction(() async {
      await db.subscriptionDao.unsubscribePodcast(podcastId);
      await db.episodeDao.deleteEpisodesByPodcast(podcastId);
      await db.podcastDao.deletePodcast(podcastId);
    });
  }

  Future<PodcastScreenData> _getScreenData(String podcastUrlParam) async {
    final podcast = await db.podcastDao.getPodcastByUrlParam(podcastUrlParam);
    return podcast != null
        ? PodcastScreenData(
            podcast: podcast,
            episodes: await db.episodeDao.getEpisodesByPodcast(podcast.id),
            isSubscribed: await db.subscriptionDao.isSubscribed(podcast.id),
            receivedAllEpisodes: true,
          )
        : null;
  }

  /// Returns true if any updates are made
  Future<bool> _updateScreenData(
    PodcastScreenData oldData,
    PodcastScreenData newData,
  ) async {
    var updated = false;
    var newEpisodes = listDifference(
      newData.episodes,
      oldData.episodes,
      (e) => e.id,
    );
    if (newEpisodes.isNotEmpty) {
      updated = true;
      await db.episodeDao.saveEpisodes(newEpisodes);
    }
    if (newData.podcast != oldData.podcast) {
      updated = true;
      await db.podcastDao.savePodcast(newData.podcast);
    }
    if (newData.podcast.isSubscribed != oldData.podcast.isSubscribed) {
      newData.podcast.isSubscribed
          ? await db.subscriptionDao.subscribePodcast(newData.podcast.id)
          : await db.subscriptionDao.unsubscribePodcast(newData.podcast.id);
    }
    return updated;
  }
}
