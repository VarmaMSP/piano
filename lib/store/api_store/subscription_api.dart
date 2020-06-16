import 'package:phenopod/store/store.dart';

import 'utils.dart';

class SubscriptionApi extends SubscriptionStore {
  @override
  Future<void> subscribe(String podcastId) async {
    await makeRequest(
      method: 'POST',
      path: '/ajax/service?endpoint=subscribe_podcast',
      body: <String, dynamic>{'podcast_id': podcastId},
    );
  }

  @override
  Future<void> unsubscribe(String podcastId) async {
    await makeRequest(
      method: 'POST',
      path: '/ajax/service?endpoint=unsubscribe_podcast',
      body: <String, dynamic>{'podcast_id': podcastId},
    );
  }
}
