import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/db_layer/playback_db.dart';
import 'package:phenopod/store/db_layer/preference_db.dart';
import 'package:phenopod/store/db_layer/audio_player_db.dart';
import 'package:phenopod/store/db_layer/podcast_db.dart';
import 'package:phenopod/store/db_layer/subscription_db.dart';
import 'package:phenopod/store/db_layer/task_queue_db.dart';
import 'package:phenopod/store/store.dart';

import 'db.dart';

class DbLayer extends Store {
  final Store baseStore;
  final Db db;
  PodcastStore _podcastDb;
  AudioPlayerStore _audioPlayerDb;
  PlaybackPositionStore _playbackPositionDb;
  SubscriptionStore _subscriptionDb;
  PreferenceStore _preferenceDb;
  TaskQueueStore _taskQueueDb;

  DbLayer({this.baseStore, SqlDb sqlDb}) : db = Db(sqlDb: sqlDb) {
    _podcastDb = PodcastDb(
      baseStore: baseStore.podcast,
      episodeBaseStore: baseStore.episode,
      db: db,
    );
    _audioPlayerDb = AudioPlayerDb(
      baseStore: null,
      db: db,
    );
    _playbackPositionDb = PlaybackPositionDb(
      baseStore: null,
      db: db,
    );
    _subscriptionDb = SubscriptionDb(
      baseStore: baseStore.subscription,
      db: db,
    );
    _preferenceDb = PreferenceDb(
      baseStore: null,
      sqldb: sqlDb,
    );
    _taskQueueDb = TaskQueueDb(
      db: db,
    );
  }

  @override
  EpisodeStore get episode => baseStore.episode;

  @override
  PodcastStore get podcast => _podcastDb;

  @override
  SubscriptionStore get subscription => _subscriptionDb;

  @override
  UserStore get user => baseStore.user;

  @override
  AudioPlayerStore get audioPlayer => _audioPlayerDb;

  @override
  PlaybackPositionStore get playbackPosition => _playbackPositionDb;

  @override
  PreferenceStore get preference => _preferenceDb;

  @override
  TaskQueueStore get taskQueue => _taskQueueDb;
}
