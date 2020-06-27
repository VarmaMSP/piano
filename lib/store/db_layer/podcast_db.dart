import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/utils.dart';

import 'db.dart';

class PodcastDb extends PodcastStore {
  final Db db;
  final PodcastStore baseStore;

  PodcastDb({this.baseStore, this.db});

  @override
  Future<void> save(Podcast podcast) {
    return db.podcastDao.savePodcast(podcast);
  }

  @override
  Stream<PodcastScreenData> watchScreenData(String podcastUrlParam) async* {
    var podcast = await db.podcastDao.getPodcastByUrlParam(podcastUrlParam);
    var episodes = <Episode>[];
    if (podcast != null) {
      episodes = await db.episodeDao.getEpisodesByPodcast(podcast.id);
      yield PodcastScreenData(
        podcast: podcast,
        episodes: episodes,
        receivedAllEpisodes: true,
      );
    }

    var screenData = await baseStore.watchScreenData(podcastUrlParam).first;
    if (podcast == null) {
      /// return data from api if podcast is not cached
      yield screenData;
    } else {
      /// apply any updates if required
      final newEpisodes = listDifference(
        screenData.episodes,
        episodes,
        (e) => e.id,
      );
      if (newEpisodes.isNotEmpty) {
        await db.episodeDao.saveEpisodes(newEpisodes);
      }
    }
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

  @override
  Future<void> deletePodcastWithEpisodes(String podcastId) {
    return db.transaction(() async {
      await db.episodeDao.deleteEpisodesByPodcast(podcastId);
      await db.podcastDao.deletePodcast(podcastId);
    });
  }
}
