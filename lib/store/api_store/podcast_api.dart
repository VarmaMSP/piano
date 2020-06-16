import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';

import 'utils.dart';

class PodcastApi extends PodcastStore {
  @override
  Future<Podcast> get(String podcastId) {
    throw UnimplementedError();
  }

  @override
  Future<PodcastScreenData> getScreenData(String podcastUrlParam) async {
    final apiResponse = await makeRequest(
      method: 'GET',
      path: '/podcasts/$podcastUrlParam',
    );

    return PodcastScreenData(
      podcast: apiResponse.podcasts[0],
      episodes: apiResponse.episodes,
      receivedAllEpisodes: apiResponse.episodes.length < 15,
    );
  }
}
