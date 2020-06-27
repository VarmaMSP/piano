import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/utils.dart';

class PodcastDb extends PodcastStore {
  final SqlDb sqlDb;
  final Store baseStore;
  PodcastDao _podcastDao;
  EpisodeDao _episodeDao;

  PodcastDb({this.baseStore, this.sqlDb}) {
    _podcastDao = PodcastDao(sqlDb);
    _episodeDao = EpisodeDao(sqlDb);
  }

  @override
  Future<PodcastScreenData> getScreenData(String podcastUrlParam) async {
    return _podcastDao.getScreenData(podcastUrlParam);
  }

  @override
  Stream<PodcastScreenData> watchScreenData(String podcastUrlParam) async* {
    final fromDb = await _podcastDao.getScreenData(podcastUrlParam);
    if (fromDb != null) {
      yield fromDb.copyWith(receivedAllEpisodes: true);
    }

    final fromApi = await baseStore.podcast.getScreenData(podcastUrlParam);
    yield PodcastScreenData(
      podcast: fromApi.podcast,
      episodes: listRemoveDuplicates(
        [...fromApi.episodes, ...(fromDb?.episodes ?? [])],
        (x) => x.id,
      ),
      receivedAllEpisodes:
          fromDb?.receivedAllEpisodes ?? fromApi.receivedAllEpisodes,
    );
  }

  @override
  Future<void> saveScreeData(String podcastUrlParam) async {
    final screenData = await baseStore.podcast.getScreenData(podcastUrlParam);
    await _podcastDao.saveScreenData(screenData);

    var receivedAll = screenData.receivedAllEpisodes;
    var episodesLength = screenData.episodes.length;
    while (!receivedAll) {
      final episodes = await baseStore.episode.getByPodcastPaginated(
        screenData.podcast.id,
        episodesLength,
        30,
      );
      await _podcastDao.saveEpisodes(episodes);
      if (episodes.length < 30) {
        receivedAll = true;
      }
      episodesLength += episodes.length;
    }
  }

  @override
  Future<void> deleteScreenData(String podcastUrlParam) {
    throw UnimplementedError();
  }

  @override
  Future<void> save(Podcast podcast) {
    return _podcastDao.savePodcast(podcast);
  }

  @override
  Future<void> savePodcastWithEpisodes(
    Podcast podcast,
    List<Episode> episodes,
  ) {
    return sqlDb.transaction(() async {
      await _podcastDao.savePodcast(podcast);
      await _episodeDao.saveEpisodes(episodes);
    });
  }
}
