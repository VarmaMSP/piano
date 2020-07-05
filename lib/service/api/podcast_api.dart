import 'package:flutter/foundation.dart';
import 'package:phenopod/model/podcast.dart';
import 'package:phenopod/service/http_client.dart';

PodcastApi newPodcastApi(HttpClient httpClient) {
  return _PodcastApiImpl(httpClient);
}

abstract class PodcastApi {
  Future<Podcast> getPage({@required String urlParam});
}

class _PodcastApiImpl extends PodcastApi {
  final HttpClient httpClient;

  _PodcastApiImpl(this.httpClient);

  @override
  Future<Podcast> getPage({String urlParam}) async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/podcasts/$urlParam',
    );
    return apiResponse.podcasts[0]?.copyWith(
      episodes: apiResponse.episodes,
      moreEpisodes: apiResponse.episodes.length < 15,
    );
  }
}
