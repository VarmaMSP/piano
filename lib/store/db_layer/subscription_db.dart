import 'package:phenopod/model/screen.dart';
import 'package:phenopod/store/store.dart';

class SubscriptionDb extends SubscriptionStore {
  final SubscriptionStore baseStore;

  SubscriptionDb({this.baseStore});

  @override
  Future<SubscriptionsScreenData> getScreenData() {
    return baseStore.getScreenData();
  }

  @override
  Future<void> subscribe(String podcastId) {
    return baseStore.subscribe(podcastId);
  }

  @override
  Future<void> unsubscribe(String podcastId) {
    return baseStore.unsubscribe(podcastId);
  }
}
