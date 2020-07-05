import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';
import 'package:tuple/tuple.dart';

import 'http_client.dart';

PodcastApi newPodcastApi(HttpClient httpClient) {
  return _PodcastApiImpl(httpClient);
}

abstract class PodcastApi {
  Future<Tuple2<Podcast, List<Episode>>> getPage({@required String urlParam});
}

class _PodcastApiImpl extends PodcastApi {
  final HttpClient httpClient;

  _PodcastApiImpl(this.httpClient);

  @override
  Future<Tuple2<Podcast, List<Episode>>> getPage({String urlParam}) async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/podcasts/$urlParam',
    );
    return Tuple2(
      apiResponse.podcasts[0],
      apiResponse.episodes,
    );
  }
}
