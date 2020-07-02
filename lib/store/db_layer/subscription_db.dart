import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';

import 'db.dart';

class SubscriptionDb extends SubscriptionStore {
  final Db db;
  final SubscriptionStore baseStore;

  SubscriptionDb({this.baseStore, this.db});

  @override
  Future<void> subscribe(Podcast podcast) async {
    await baseStore.subscribe(podcast);
    await db.transaction(() async {
      await db.podcastDao.savePodcasts([podcast]);
      await db.subscriptionDao.saveSubscription(
        Subscription(podcastId: podcast.id),
      );
    });
    await db.taskDao.saveTasks([Task.cachePodcast(urlParam: podcast.urlParam)]);
  }

  @override
  Future<void> unsubscribe(Podcast podcast) async {
    await baseStore.unsubscribe(podcast);
    await db.subscriptionDao.deleteSubscription(podcast.id);
  }

  @override
  Future<SubscriptionsFeed> getFeed() {
    return baseStore.getFeed();
  }

  @override
  Stream<SubscriptionsFeed> watchFeed() async* {
    final subscriptions = db.podcastDao.watchSubscribedPodcasts();
    await for (var ps in subscriptions) {
      yield* db.episodeDao
          .watchEpisodesFromPodcasts(ps.map((p) => p.id).toList())
          .map((episodes) => SubscriptionsFeed(
                podcasts: ps,
                episodes: episodes,
              ));
    }
  }

  @override
  Future<void> updateFeed() async {
    final feed = await baseStore.getFeed();
    await db.taskDao.saveTasks(
      feed.subscriptionById.values
          .map((p) => Task.cachePodcast(urlParam: p.urlParam))
          .toList(),
    );
  }
}
