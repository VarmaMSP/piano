import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/http_client.dart';
import 'package:phenopod/store/store.dart';

class SubscriptionApi extends SubscriptionStore {
  final HttpClient httpClient;

  SubscriptionApi(this.httpClient);

  @override
  Future<void> subscribe(Podcast podcast) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/ajax/service',
      queryParams: {'endpoint': 'subscribe_podcast'},
      body: <String, dynamic>{'podcast_id': podcast.id},
    );
  }

  @override
  Future<void> unsubscribe(Podcast podcast) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/ajax/service',
      queryParams: {'endpoint': 'unsubscribe_podcast'},
      body: <String, dynamic>{'podcast_id': podcast.id},
    );
  }

  @override
  Future<SubscriptionsFeed> getFeed() async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/subscriptions',
    );
    return SubscriptionsFeed(
      episodes: apiResponse.episodes,
      podcasts: apiResponse.podcasts,
    );
  }

  @override
  Stream<SubscriptionsFeed> watchFeed() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateFeed() {
    throw UnimplementedError();
  }
}
