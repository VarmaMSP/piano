import 'dart:async';

import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:rxdart/rxdart.dart';

import 'db.dart';

class PodcastDb extends PodcastStore {
  final Db db;
  final PodcastStore baseStore;
  final EpisodeStore episodeBaseStore;

  PodcastDb({this.baseStore, this.episodeBaseStore, this.db});

  @override
  Future<Podcast> get_(String podcastUrlParam) {
    return baseStore.get_(podcastUrlParam);
  }

  // ignore: todo
  // TODO: sync subscribe and unsubscribe events from different clients
  @override
  Stream<Podcast> watch(String podcastUrlParam) async* {
    if (await isCached(urlParam: podcastUrlParam)) {
      // ignore: unawaited_futures
      baseStore.get_(podcastUrlParam).then((podcast) async {
        await db.transaction(() async {
          await db.podcastDao.savePodcast(podcast);
          await db.episodeDao.saveEpisodes(podcast.episodes);
        });
        if (podcast.isSubscribed) {
          await db.taskDao.saveTask(
            Task.cachePodcast(urlParam: podcast.urlParam),
          );
        }
      });

      yield* _watchCache(urlParam: podcastUrlParam);
    } else {
      final podcast = await baseStore.get_(podcastUrlParam);
      yield podcast;
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
      await db.podcastDao.savePodcast(podcast.copyWith(
        isCached: true,
        cachedAt: DateTime.now(),
        moreEpisodes: false,
      ));
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
      db.podcastDao.watchPodcast(id),
      db.episodeDao.watchEpisodesFromPodcast(id),
      db.subscriptionDao.watchPodcastSubscription(id),
      (podcast, episodes, subscription) => podcast?.copyWith(
        episodes: episodes,
        isSubscribed: subscription != null,
      ),
    );
  }
}
