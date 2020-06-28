import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/store/store.dart';

class PodcastApi extends PodcastStore {
  final HttpClient httpClient;

  PodcastApi(this.httpClient);

  @override
  Stream<PodcastScreenData> watchScreenData(String podcastUrlParam) async* {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/podcasts/$podcastUrlParam',
    );

    yield PodcastScreenData(
      podcast: apiResponse.podcasts[0],
      episodes: apiResponse.episodes,
      isSubscribed: apiResponse.podcasts[0].isSubscribed,
      receivedAllEpisodes: apiResponse.episodes.length < 15,
    );
  }

  @override
  Future<void> save(Podcast podcast) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveScreenData(PodcastScreenData screenData) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteScreenData(String podcastId) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isCached({String id, String urlParam}) {
    throw UnimplementedError();
  }
}
