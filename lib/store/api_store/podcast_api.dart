import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/store/store.dart';

class PodcastApi extends PodcastStore {
  final HttpClient httpClient;

  PodcastApi(this.httpClient);

  @override
  Future<PodcastScreenData> getScreenData(String podcastUrlParam) async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/podcasts/$podcastUrlParam',
    );

    return PodcastScreenData(
      podcast: apiResponse.podcasts[0],
      episodes: apiResponse.episodes,
      receivedAllEpisodes: apiResponse.episodes.length < 15,
    );
  }

  @override
  Future<void> deleteScreenData(String podcastUrlParam) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveScreeData(String podcastUrlParam) {
    throw UnimplementedError();
  }

  @override
  Stream<PodcastScreenData> watchScreenData(String podcastUrlParam) {
    throw UnimplementedError();
  }
}
