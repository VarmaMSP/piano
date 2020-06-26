import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/db_layer/playback_db.dart';
import 'package:phenopod/store/db_layer/preference_db.dart';
import 'package:phenopod/store/db_layer/queue_db.dart';
import 'package:phenopod/store/db_layer/podcast_db.dart';
import 'package:phenopod/store/store.dart';

class DbLayer extends Store {
  final Store baseStore;
  PodcastStore _podcastDb;
  QueueStore _queueDb;
  PlaybackPositionStore _playbackPositionDb;
  PreferenceStore _preferenceDb;

  DbLayer({this.baseStore, SqlDb sqlDb}) {
    _podcastDb = PodcastDb(baseStore: baseStore, sqlDb: sqlDb);
    _queueDb = QueueDb(baseStore: null, sqlDb: sqlDb);
    _playbackPositionDb = PlaybackPositionDb(baseStore: null, sqlDb: sqlDb);
    _preferenceDb = PreferenceDb(baseStore: null, sqldb: sqlDb);
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
  PlaybackPositionStore get playbackPosition => _playbackPositionDb;

  @override
  PreferenceStore get preference => _preferenceDb;
}
