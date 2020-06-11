import 'package:phenopod/utils/request.dart';

class SubscriptionRepository {
  Future<void> subscribe(String podcastId) async {
    await makeRequest(
      method: 'POST',
      path: '/ajax/service?endpoint=subscribe_podcast',
      body: <String, dynamic>{'podcast_id': podcastId},
    );
  }

  Future<void> unsubscribe(String podcastId) async {
    await makeRequest(
      method: 'POST',
      path: '/ajax/service?endpoint=unsubscribe_podcast',
      body: <String, dynamic>{'podcast_id': podcastId},
    );
  }
}
