import 'package:phenopod/model/episode.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';

class EpisodeDb extends EpisodeStore {
  final EpisodeStore baseStore;
  EpisodeDao _episodeDao;

  EpisodeDb({this.baseStore, SqlDb sqlDb}) {
    _episodeDao = EpisodeDao(sqlDb);
  }

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
    return _episodeDao.saveEpisodes(episodes);
  }
}
