import 'package:phenopod/store/store.dart';
import 'package:phenopod/model/main.dart';
import 'package:retry/retry.dart';

import 'worker.dart';

class CachePodcastToDbWorker extends Worker {
  final Store store;
  final String urlParam;

  CachePodcastToDbWorker({this.store, this.urlParam}) {
    print('worker - $urlParam');
  }

  @override
  Future<bool> shouldExecute() async {
    return !(await store.podcast.isCached(urlParam: urlParam));
  }

  @override
  Future<void> execute() async {
    var screenData = await store.podcast.watchScreenData(urlParam).first;
    if (!screenData.receivedAllEpisodes) {
      var episodes = await _getEpisodes(
        podcastId: screenData.podcast.id,
        offset: screenData.episodes.length,
      );
      screenData = screenData.copyWith(
        episodes: [...screenData.episodes, ...episodes],
      );
    }
    await store.podcast.saveScreenData(screenData);
  }

  Future<List<Episode>> _getEpisodes({String podcastId, int offset}) async {
    var episodes = <Episode>[];
    while (true) {
      final newEpisodes = await RetryOptions(
        maxAttempts: 3,
        delayFactor: Duration(seconds: 20),
      ).retry(
        () => store.episode.getByPodcastPaginated(
          podcastId,
          episodes.length + offset,
          75,
        ),
      );

      episodes = [...episodes, ...newEpisodes];
      if (newEpisodes.length < 75) {
        return episodes;
      }
    }
  }
}
