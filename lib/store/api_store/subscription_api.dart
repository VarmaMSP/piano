import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/http_client.dart';
import 'package:phenopod/store/store.dart';

class SubscriptionApi extends SubscriptionStore {
  final HttpClient httpClient;

  SubscriptionApi(this.httpClient);

  @override
  Future<void> subscribe(String podcastId) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/ajax/service',
      queryParams: {'endpoint': 'subscribe_podcast'},
      body: <String, dynamic>{'podcast_id': podcastId},
    );
  }

  @override
  Future<void> unsubscribe(String podcastId) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/ajax/service',
      queryParams: {'endpoint': 'unsubscribe_podcast'},
      body: <String, dynamic>{'podcast_id': podcastId},
    );
  }

  @override
  Future<SubscriptionsScreenData> getScreenData() async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/subscriptions',
    );
    return SubscriptionsScreenData(
      podcastById: {for (var p in apiResponse.podcasts) p.id: p},
      episodes: apiResponse.episodes,
    );
  }
}
