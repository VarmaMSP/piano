// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/store/store.dart';
import 'worker.dart';

class CachePodcastWorker extends Worker {
  final String podcastId;
  final String podcastUrlParam;

  CachePodcastWorker({
    @required int taskId,
    @required Store store,
    @required this.podcastId,
    @required this.podcastUrlParam,
  }) : super(taskId: taskId, store: store);

  @override
  Future<bool> shouldExecute() async {
    final podcast = await store.db.podcastDao.watchPodcast(podcastId).first;
    return podcast == null || !podcast.cachedAllEpisodes;
  }

  @override
  Future<void> execute() async {
    try {
      /// Cache podcast
      final podcast = await store.db.podcastDao.watchPodcast(podcastId).first;
      if (podcast == null) {
        await store.podcast
            .watchByUrlParam(podcastUrlParam)
            .where((p) => p != null)
            .first;
      }

      /// Load all episodes from db
      var episodes = await store.db.episodeDao.watchEpisodesByPodcastsPaginated(
        podcastIds: [podcastId],
        offset: 0,
        limit: 10000,
      ).first;
      var episodeCount = episodes.length;

      /// Paginate all episodes
      do {
        episodes = await store.api.episode.getByPodcastPaginated(
          podcastId: podcastId,
          offset: episodeCount,
          limit: 50,
        );
        episodeCount += episodes.length;
        await store.db.episodeDao.saveEpisodes(episodes);
      } while (episodes.length < 50);

      /// Update podcast cache details
      await store.db.podcastDao.updateCacheDetails(
        podcastId,
        cachedAllEpisodes: true,
      );
    } finally {
      await deleteTask();
    }
  }

  @override
  Future<void> dispose() async {}
}
