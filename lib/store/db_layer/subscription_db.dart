import 'package:phenopod/model/main.dart';
import 'package:phenopod/model/screen.dart';
import 'package:phenopod/store/store.dart';

import 'db.dart';

class SubscriptionDb extends SubscriptionStore {
  final Db db;
  final SubscriptionStore baseStore;

  SubscriptionDb({this.baseStore, this.db});

  @override
  Future<SubscriptionsScreenData> getScreenData() {
    return baseStore.getScreenData();
  }

  @override
  Future<void> subscribe(Podcast podcast) async {
    await baseStore.subscribe(podcast);
    await db.taskDao.saveTask(Task.cachePodcast(urlParam: podcast.urlParam));
  }

  @override
  Future<void> unsubscribe(Podcast podcast) {
    return baseStore.unsubscribe(podcast);
  }
}
