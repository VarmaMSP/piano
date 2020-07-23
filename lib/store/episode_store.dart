// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

EpisodeStore newEpisodeStore(Api api, Db db) {
  return _EpisodeStoreImpl(api: api, db: db);
}

abstract class EpisodeStore {
  Stream<List<Episode>> watchByPodcastPaginated({
    @required String podcastId,
    @required int offset,
    @required int limit,
  });
  Stream<List<Episode>> watchByPodcastsPaginated({
    @required List<String> podcastIds,
    @required int offset,
    @required int limit,
  });
}

class _EpisodeStoreImpl extends EpisodeStore {
  final Api api;
  final Db db;

  _EpisodeStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Stream<List<Episode>> watchByPodcastPaginated({
    String podcastId,
    int offset,
    int limit,
  }) async* {
    final episodesStream = db.episodeDao.watchEpisodesByPodcastsPaginated(
      podcastIds: [podcastId],
      offset: offset,
      limit: limit,
    );

    final episodes = await episodesStream.first;
    // first page will be loaded from podcast page
    if (episodes.isEmpty && offset > 0) {
      // ignore: unawaited_futures
      api.episode
          .getByPodcastPaginated(
            podcastId: podcastId,
            offset: offset,
            limit: limit,
          )
          .then(
            (episodes) => db.transaction(() async {
              await db.episodeDao.saveEpisodes(episodes);
              if (episodes.length < 30) {
                await db.podcastDao.updateCacheDetails(
                  podcastId,
                  cachedAllEpisodes: true,
                );
              }
            }),
          );
    }

    yield episodes;
    yield* episodesStream;
  }

  @override
  Stream<List<Episode>> watchByPodcastsPaginated({
    List<String> podcastIds,
    int offset,
    int limit,
  }) {
    return db.episodeDao.watchEpisodesByPodcastsPaginated(
      podcastIds: podcastIds,
      offset: offset,
      limit: limit,
    );
  }
}
