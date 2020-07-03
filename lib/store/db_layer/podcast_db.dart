import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/http_client.dart';
import 'package:phenopod/store/store.dart';
import 'package:rxdart/rxdart.dart';

import 'db.dart';

class PodcastDb extends PodcastStore {
  final Db db;
  final HttpClient httpClient;
  final PodcastStore baseStore;
  final EpisodeStore episodeBaseStore;

  PodcastDb({
    @required this.baseStore,
    @required this.episodeBaseStore,
    @required this.db,
    @required this.httpClient,
  });

  @override
  Future<Podcast> get_(String podcastUrlParam) {
    return baseStore.get_(podcastUrlParam);
  }

  @override
  Stream<Podcast> watch(String podcastUrlParam) async* {
    if (await isCached(urlParam: podcastUrlParam)) {
      // ignore: unawaited_futures
      baseStore.get_(podcastUrlParam).then((podcast) async {
        await db.transaction(() async {
          await db.podcastDao.savePodcasts([podcast]);
          await db.episodeDao.saveEpisodes(podcast.episodes);
          !podcast.isSubscribed
              ? await db.subscriptionDao.deleteSubscription(podcast.id)
              : await db.subscriptionDao.saveSubscription(
                  Subscription(podcastId: podcast.id),
                );
        });
      });
      yield* _watchCache(urlParam: podcastUrlParam);
    } else {
      final podcast = await baseStore.get_(podcastUrlParam);
      yield podcast;

      if (podcast.isSubscribed) {
        await db.taskDao.saveTasks([
          Task.cachePodcast(urlParam: podcast.urlParam),
        ]);
      }
    }
  }

  @override
  Future<bool> isCached({String id, String urlParam}) async {
    assert((id != null) != (urlParam != null));
    final podcast = await db.podcastDao.getPodcast(id: id, urlParam: urlParam);
    return podcast != null && podcast.isCached;
  }

  @override
  Future<void> cache(String urlParam) async {
    final podcast = await baseStore.get_(urlParam);
    final episodes = podcast.episodes;
    while (!podcast.moreEpisodes) {
      final moreEpisodes = await episodeBaseStore.getByPodcastPaginated(
        podcast.id,
        episodes.length,
        75,
      );
      episodes.addAll(moreEpisodes);
      if (moreEpisodes.length < 75) {
        break;
      }
    }

    await db.transaction(() async {
      await db.podcastDao.savePodcasts([
        podcast.copyWith(
          isCached: true,
          cachedAt: DateTime.now(),
          moreEpisodes: false,
        )
      ]);
      await db.episodeDao.saveEpisodes(episodes);
    });
  }

  @override
  Future<void> deleteCache({String id, String urlParam}) async {
    assert((id != null) != (urlParam != null));
    final podcast = await db.podcastDao.getPodcast(id: id, urlParam: urlParam);

    if (podcast == null || !podcast.isCached) {
      return;
    }
    id ??= podcast.id;
    await db.transaction(() async {
      await db.episodeDao.deleteEpisodesFromPodcast(id);
      await db.podcastDao.deletePodcasts([id]);
    });
  }

  Stream<Podcast> _watchCache({String id, String urlParam}) async* {
    assert((id != null) != (urlParam != null));
    id ??= (await db.podcastDao.getPodcast(id: id, urlParam: urlParam)).id;

    yield* Rx.combineLatest3<Podcast, List<Episode>, Subscription, Podcast>(
      db.podcastDao.watchPodcast(id: id),
      db.episodeDao.watchEpisodesFromPodcast(id),
      db.subscriptionDao.watchSubscription(id),
      (podcast, episodes, subscription) => podcast?.copyWith(
        episodes: episodes,
        isSubscribed: subscription != null,
      ),
    );
  }

  @override
  Future<void> refresh(String urlParam) async {
    final podcast = await db.podcastDao.getPodcast(urlParam: urlParam);
    final isAlreadyCached = podcast?.isCached ?? false;

    /// Load podcast and episodes from podcast page
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/podcasts/$urlParam',
    );
    await db.transaction(() async {
      await db.podcastDao.savePodcasts(
        apiResponse.podcasts
            .map(
              (p) => p.copyWith(
                isCached: true,
                cachedAt: DateTime.now(),
                moreEpisodes: false,
              ),
            )
            .toList(),
      );
      await db.episodeDao.saveEpisodes(apiResponse.episodes);
    });

    /// Paginate through episodes and load them into db
    if (isAlreadyCached || apiResponse.episodes.length < 15) {
      return;
    }
    var id = apiResponse.podcasts[0].id;
    var offset = apiResponse.episodes.length;
    var limit = 75;
    while (true) {
      final apiResponse = await httpClient.makeRequest(
        method: 'GET',
        path: '/ajax/browse',
        queryParams: {
          'endpoint': 'podcast_episodes',
          'podcast_id': id,
          'offset': offset.toString(),
          'limit': limit.toString(),
          'order': 'pub_date_desc',
        },
      );
      await db.episodeDao.saveEpisodes(apiResponse.episodes);

      offset += apiResponse.episodes.length;
      if (apiResponse.episodes.length < limit) {
        return;
      }
    }
  }

  @override
  Stream<Podcast> watch_(String urlParam) {
    return db.podcastDao.watchPodcast(urlParam: urlParam);
  }
}
