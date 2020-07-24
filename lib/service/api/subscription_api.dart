// Package imports:
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/http_client.dart';

SubscriptionApi newSubscriptionApi(HttpClient httpClient) {
  return _SubscriptionApiImpl(httpClient);
}

abstract class SubscriptionApi {
  Future<void> subscribe(String podcastId);
  Future<void> unsubscribe(String podcastId);
  Future<Tuple2<List<Podcast>, List<Episode>>> getPage();
}

class _SubscriptionApiImpl extends SubscriptionApi {
  final HttpClient httpClient;

  _SubscriptionApiImpl(this.httpClient);

  @override
  Future<void> subscribe(String podcastId) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/ajax/service',
      queryParams: {'endpoint': 'subscribe_podcast'},
      body: {'podcast_id': podcastId},
    );
  }

  @override
  Future<void> unsubscribe(String podcastId) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/ajax/service',
      queryParams: {'endpoint': 'unsubscribe_podcast'},
      body: {'podcast_id': podcastId},
    );
  }

  @override
  Future<Tuple2<List<Podcast>, List<Episode>>> getPage() async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/subscriptions',
    );
    return Tuple2(
      apiResponse.podcasts,
      apiResponse.episodes,
    );
  }
}
