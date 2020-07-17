// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/episode.dart';
import 'http_client.dart';

EpisodeApi newEpisodeApi(HttpClient httpClient) {
  return _EpisodeApiImpl(httpClient);
}

abstract class EpisodeApi {
  Future<List<Episode>> getByPodcastPaginated({
    @required String podcastId,
    @required int offset,
    @required int limit,
  });
}

class _EpisodeApiImpl extends EpisodeApi {
  final HttpClient httpClient;

  _EpisodeApiImpl(this.httpClient);

  @override
  Future<List<Episode>> getByPodcastPaginated({
    String podcastId,
    int offset,
    int limit,
  }) async {
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
}
