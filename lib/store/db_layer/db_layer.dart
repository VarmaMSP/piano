import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/db_layer/queue_db.dart';
import 'package:phenopod/store/db_layer/podcast_db.dart';
import 'package:phenopod/store/store.dart';

class DbLayer extends Store {
  final Store baseStore;
  PodcastStore _podcastDb;
  QueueStore _queueDb;

  DbLayer({this.baseStore, SqlDb sqlDb}) {
    _podcastDb = PodcastDb(
      baseStore: baseStore.podcast,
      sqlDb: sqlDb,
    );
    _queueDb = QueueDb(
      baseStore: null,
      sqlDb: sqlDb,
    );
  }

  @override
  EpisodeStore get episode => baseStore.episode;

  @override
  PodcastStore get podcast => _podcastDb;

  @override
  SubscriptionStore get subscription => baseStore.subscription;

  @override
  UserStore get user => baseStore.user;

  @override
  QueueStore get queue => _queueDb;

  @override
  PlaybackStore get playback => throw UnimplementedError();
}
