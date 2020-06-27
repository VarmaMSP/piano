import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/db_layer/playback_db.dart';
import 'package:phenopod/store/db_layer/preference_db.dart';
import 'package:phenopod/store/db_layer/audio_player_db.dart';
import 'package:phenopod/store/db_layer/podcast_db.dart';
import 'package:phenopod/store/db_layer/task_db.dart';
import 'package:phenopod/store/store.dart';

import 'db.dart';

class DbLayer extends Store {
  final Store baseStore;
  final Db db;
  PodcastStore _podcastDb;
  AudioPlayerStore _audioPlayerDb;
  PlaybackPositionStore _playbackPositionDb;
  PreferenceStore _preferenceDb;
  TaskStore _taskDb;

  DbLayer({this.baseStore, SqlDb sqlDb}) : db = Db(sqlDb: sqlDb) {
    _podcastDb = PodcastDb(baseStore: baseStore, db: db);
    _audioPlayerDb = AudioPlayerDb(baseStore: null, db: db);
    _playbackPositionDb = PlaybackPositionDb(baseStore: null, sqlDb: sqlDb);
    _preferenceDb = PreferenceDb(baseStore: null, sqldb: sqlDb);
    _taskDb = TaskDb(sqlDb: sqlDb);
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
  AudioPlayerStore get audioPlayer => _audioPlayerDb;

  @override
  PlaybackPositionStore get playbackPosition => _playbackPositionDb;

  @override
  PreferenceStore get preference => _preferenceDb;

  @override
  TaskStore get task => _taskDb;
}
