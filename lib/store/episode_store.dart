// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/alarm_service/alarm_service.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/utils/utils.dart';

EpisodeStore newEpisodeStore(Api api, Db db, [AlarmService alarmService]) {
  return _EpisodeStoreImpl(api: api, db: db, alarmService: alarmService);
}

abstract class EpisodeStore {
  Future<void> refresh(String urlParam);
  Stream<Episode> watchByUrlParam(String urlParam);
  Stream<EpisodeMeta> watchMeta(String episodeId);
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
  final AlarmService alarmService;

  _EpisodeStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
  });

  @override
  Future<void> refresh(String urlParam) async {
    final data = await api.episode.getByUrlParam(urlParam);
    final podcast = data.item1;
    final episode = data.item2;

    await db.transaction(() async {
      await db.podcastDao.savePodcasts([podcast]);
      await db.episodeDao.saveEpisodes([episode]);
    });
  }

  @override
  Stream<Episode> watchByUrlParam(String urlParam) {
    return db.episodeDao.watchEpisodeById(getIdFromUrlParam(urlParam));
  }

  @override
  Stream<EpisodeMeta> watchMeta(String episodeId) {
    return Rx.combineLatest2<DownloadProgress, AudioTrack, EpisodeMeta>(
      db.audioFileDao.watchProgressByEpisode(episodeId),
      db.audioTrackDao.watchAllTracks().map(
            (tracks) => tracks.firstWhere(
              (track) => track.episode.id == episodeId,
              orElse: () => null,
            ),
          ),
      (downloadProgress, audioTrack) => EpisodeMeta(
        downloadProgress: downloadProgress,
        audioTrack: audioTrack,
      ),
    );
  }

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
