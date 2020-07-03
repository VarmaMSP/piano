import 'package:phenopod/model/episode.dart';
import 'package:phenopod/store/db_layer/db.dart';
import 'package:phenopod/store/store.dart';

class EpisodeDb extends EpisodeStore {
  final Db db;
  final EpisodeStore baseStore;

  EpisodeDb({this.baseStore, this.db});

  @override
  Future<List<Episode>> getByPodcastPaginated(
    String podcastId,
    int offset,
    int limit,
  ) {
    return baseStore.getByPodcastPaginated(podcastId, offset, limit);
  }

  @override
  Future<List<Episode>> getFromSubscriptionsPaginated(
    int offset,
    int limit,
  ) {
    return baseStore.getFromSubscriptionsPaginated(offset, limit);
  }

  @override
  Future<void> saveAll(List<Episode> episodes) {
    return db.episodeDao.saveEpisodes(episodes);
  }

  @override
  Stream<List<Episode>> watchByPodcast(String podcastId) {
    return db.episodeDao.watchEpisodesFromPodcast(podcastId);
  }
}
