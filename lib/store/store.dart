// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/services/alarm_service/alarm_service.dart';
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/db/db.dart';
import 'audio_file_store.dart';
import 'audio_player_store.dart';
import 'episode_store.dart';
import 'playback_position_store.dart';
import 'podcast_store.dart';
import 'search_store.dart';
import 'setting_store.dart';
import 'subscription_store.dart';
import 'task_store.dart';
import 'user_store.dart';

Store newStore(Api api, Db db, AlarmService alarmService) {
  return _StoreImpl(
    api: api,
    db: db,
    alarmService: alarmService,
    lazyQueries: true,
  );
}

Store newStoreForBackground(Api api, Db db) {
  return _StoreImpl(
    api: api,
    db: db,
    alarmService: null,
    lazyQueries: false,
  );
}

abstract class Store {
  UserStore get user;
  PodcastStore get podcast;
  EpisodeStore get episode;
  SubscriptionStore get subscription;
  AudioPlayerStore get audioPlayer;
  PlaybackPositionStore get playbackPosition;
  TaskStore get task;
  AudioFileStore get audioFile;
  SettingStore get setting;
  SearchStore get search;
}

class _StoreImpl extends Store {
  final UserStore _userStore;
  final PodcastStore _podcastStore;
  final EpisodeStore _episodeStore;
  final SubscriptionStore _subscriptionStore;
  final AudioPlayerStore _audioPlayerStore;
  final PlaybackPositionStore _playbackPositionStore;
  final TaskStore _taskStore;
  final AudioFileStore _audioFileStore;
  final SettingStore _settingStore;
  final SearchStore _searchStore;

  _StoreImpl({
    @required Api api,
    @required Db db,
    @required AlarmService alarmService,
    @required bool lazyQueries,
  })  : _userStore = newUserStore(api, db, alarmService, lazyQueries),
        _podcastStore = newPodcastStore(api, db, alarmService, lazyQueries),
        _episodeStore = newEpisodeStore(api, db, alarmService, lazyQueries),
        _subscriptionStore =
            newSubscriptionStore(api, db, alarmService, lazyQueries),
        _audioPlayerStore =
            newAudioPlayerStore(api, db, alarmService, lazyQueries),
        _playbackPositionStore =
            newPlaybackPositionStore(api, db, alarmService, lazyQueries),
        _taskStore = newTaskStore(api, db, alarmService, lazyQueries),
        _audioFileStore = newAudioFileStore(api, db, alarmService, lazyQueries),
        _settingStore = newSettingStore(api, db, alarmService, lazyQueries),
        _searchStore = newSearchStore(api, db, alarmService, lazyQueries);

  @override
  AudioPlayerStore get audioPlayer => _audioPlayerStore;

  @override
  EpisodeStore get episode => _episodeStore;

  @override
  PlaybackPositionStore get playbackPosition => _playbackPositionStore;

  @override
  PodcastStore get podcast => _podcastStore;

  @override
  SubscriptionStore get subscription => _subscriptionStore;

  @override
  TaskStore get task => _taskStore;

  @override
  UserStore get user => _userStore;

  @override
  AudioFileStore get audioFile => _audioFileStore;

  @override
  SettingStore get setting => _settingStore;

  @override
  SearchStore get search => _searchStore;
}
