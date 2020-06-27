import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';

import 'db.dart';

class PodcastDb extends PodcastStore {
  final Db db;
  final Store baseStore;

  PodcastDb({this.baseStore, this.db});

  @override
  Future<PodcastScreenData> getScreenData(String podcastUrlParam) async {
    return db.podcastDao.getScreenData(podcastUrlParam);
  }

  @override
  Stream<PodcastScreenData> watchScreenData(String podcastUrlParam) async* {
    final fromDb = await db.podcastDao.getScreenData(podcastUrlParam);
    if (fromDb != null) {
      yield fromDb.copyWith(receivedAllEpisodes: true);
      return;
    }

    final fromApi = await baseStore.podcast.getScreenData(podcastUrlParam);
    await savePodcastWithEpisodes(fromApi.podcast, fromApi.episodes);
    yield PodcastScreenData(
      podcast: fromApi.podcast,
      episodes: fromApi.episodes,
      receivedAllEpisodes: true,
    );
  }

  @override
  Future<void> saveScreeData(String podcastUrlParam) async {
    final screenData = await baseStore.podcast.getScreenData(podcastUrlParam);
    await db.podcastDao.saveScreenData(screenData);

    var receivedAll = screenData.receivedAllEpisodes;
    var episodesLength = screenData.episodes.length;
    while (!receivedAll) {
      final episodes = await baseStore.episode.getByPodcastPaginated(
        screenData.podcast.id,
        episodesLength,
        30,
      );
      await db.podcastDao.saveEpisodes(episodes);
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
    return db.podcastDao.savePodcast(podcast);
  }

  @override
  Future<void> savePodcastWithEpisodes(
    Podcast podcast,
    List<Episode> episodes,
  ) {
    return db.transaction(() async {
      await db.podcastDao.savePodcast(podcast);
      await db.episodeDao.saveEpisodes(episodes);
    });
  }
}
