import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/db_layer/podcast_db.dart';
import 'package:phenopod/store/store.dart';

class DbLayer extends Store {
  final Store baseStore;
  PodcastStore _podcastDb;

  DbLayer({this.baseStore, SqlDb sqlDb}) {
    _podcastDb = PodcastDb(baseStore: baseStore.podcast, sqlDb: sqlDb);
  }

  @override
  EpisodeStore get episode => baseStore.episode;

  @override
  PodcastStore get podcast => _podcastDb;

  @override
  SubscriptionStore get subscription => baseStore.subscription;

  @override
  UserStore get user => baseStore.user;
}
