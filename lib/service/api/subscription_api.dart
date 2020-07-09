import 'package:phenopod/service/api/http_client.dart';

SubscriptionApi newSubscriptionApi(HttpClient httpClient) {
  return _SubscriptionApiImpl(httpClient);
}

abstract class SubscriptionApi {
  Future<void> subscribe(String podcastId);
  Future<void> unsubscribe(String podcastId);
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
}
