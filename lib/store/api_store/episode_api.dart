import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/http_client.dart';
import 'package:phenopod/store/store.dart';

class EpisodeApi extends EpisodeStore {
  final HttpClient httpClient;

  EpisodeApi(this.httpClient);

  @override
  Future<void> saveAll(List<Episode> episodes) {
    throw UnimplementedError();
  }

  @override
  Future<List<Episode>> getByPodcastPaginated(
    String podcastId,
    int offset,
    int limit,
  ) async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/ajax/browse',
      queryParams: {
        'endpoint': 'podcast_episodes',
        'podcast_id': podcastId,
        'offset': offset.toString(),
        'limit': limit.toString(),
        'order': 'pub_date_desc',
      },
    );
    return apiResponse.episodes;
  }

  @override
  Future<List<Episode>> getFromSubscriptionsPaginated(
    int offset,
    int limit,
  ) async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '`/ajax/browse',
      queryParams: {
        'endpoint': 'subscriptions_feed',
        'offset': offset.toString(),
        'limit': limit.toString(),
      },
    );
    return apiResponse.episodes;
  }

  @override
  Stream<List<Episode>> watchByPodcast(String urlParam) {
    throw UnimplementedError();
  }
}
