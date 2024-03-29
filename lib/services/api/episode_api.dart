// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'http_client.dart';

EpisodeApi newEpisodeApi(HttpClient httpClient) {
  return _EpisodeApiImpl(httpClient);
}

abstract class EpisodeApi {
  Future<Tuple2<Podcast, Episode>> getByUrlParam(String urlParam);
  Future<List<Episode>> getByPodcastPaginated({
    @required String podcastId,
    @required int offset,
    @required int limit,
  });

  Future<List<Episode>> getSubscriptionFeed({
    @required int offset,
    @required int limit,
  });
}

class _EpisodeApiImpl extends EpisodeApi {
  final HttpClient httpClient;

  _EpisodeApiImpl(this.httpClient);

  @override
  Future<Tuple2<Podcast, Episode>> getByUrlParam(String urlParam) async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/episodes/${urlParam}',
    );
    return Tuple2(
      apiResponse.podcasts[0],
      apiResponse.episodes[0],
    );
  }

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

  @override
  Future<List<Episode>> getSubscriptionFeed({
    @required int offset,
    @required int limit,
  }) async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/ajax/browse',
      queryParams: {
        'endpoint': 'subscriptions_feed',
        'offset': offset.toString(),
        'limit': limit.toString(),
      },
    );
    return apiResponse.episodes;
  }
}
