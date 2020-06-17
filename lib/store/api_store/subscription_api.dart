import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/store/store.dart';

class SubscriptionApi extends SubscriptionStore {
  final HttpClient httpClient;

  SubscriptionApi(this.httpClient);

  @override
  Future<void> subscribe(String podcastId) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/ajax/service?endpoint=subscribe_podcast',
      body: <String, dynamic>{'podcast_id': podcastId},
    );
  }

  @override
  Future<void> unsubscribe(String podcastId) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/ajax/service?endpoint=unsubscribe_podcast',
      body: <String, dynamic>{'podcast_id': podcastId},
    );
  }
}
