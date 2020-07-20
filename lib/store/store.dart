// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/store/audio_file_store.dart';
import 'audio_player_store.dart';
import 'episode_store.dart';
import 'playback_position_store.dart';
import 'podcast_store.dart';
import 'subscription_store.dart';
import 'task_store.dart';
import 'user_store.dart';

Store newStore(Api api, Db db) {
  return _StoreImpl(api: api, db: db);
}

abstract class Store {
  Db get db;
  Api get api;
  UserStore get user;
  PodcastStore get podcast;
  EpisodeStore get episode;
  SubscriptionStore get subscription;
  AudioPlayerStore get audioPlayer;
  PlaybackPositionStore get playbackPosition;
  TaskStore get task;
  AudioFileStore get audioFile;
}

class _StoreImpl extends Store {
  final Db _db;
  final Api _api;
  final UserStore _user;
  final PodcastStore _podcast;
  final EpisodeStore _episode;
  final SubscriptionStore _subscription;
  final AudioPlayerStore _audioPlayer;
  final PlaybackPositionStore _playbackPosition;
  final TaskStore _task;
  final AudioFileStore _audioFile;

  _StoreImpl({
    @required Api api,
    @required Db db,
  })  : _db = db,
        _api = api,
        _user = newUserStore(api, db),
        _podcast = newPodcastStore(api, db),
        _episode = newEpisodeStore(api, db),
        _subscription = newSubscriptionStore(api, db),
        _audioPlayer = newAudioPlayerStore(api, db),
        _playbackPosition = newPlaybackPositionStore(api, db),
        _task = newTaskStore(api, db),
        _audioFile = newAudioFileStore(api, db);

  @override
  Db get db => _db;

  @override
  Api get api => _api;

  @override
  AudioPlayerStore get audioPlayer => _audioPlayer;

  @override
  EpisodeStore get episode => _episode;

  @override
  PlaybackPositionStore get playbackPosition => _playbackPosition;

  @override
  PodcastStore get podcast => _podcast;

  @override
  SubscriptionStore get subscription => _subscription;

  @override
  TaskStore get task => _task;

  @override
  UserStore get user => _user;

  @override
  AudioFileStore get audioFile => _audioFile;
}
