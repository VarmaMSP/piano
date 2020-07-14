import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/service/download_manager/download_manager.dart';
import 'package:phenopod/store/audio_file_store.dart';

import 'user_store.dart';
import 'podcast_store.dart';
import 'episode_store.dart';
import 'subscription_store.dart';
import 'audio_player_store.dart';
import 'playback_position_store.dart';
import 'task_store.dart';

Store newStore(Api api, Db db, DownloadManager downloadManager) {
  return _StoreImpl(api: api, db: db, downloadManager: downloadManager);
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
}

class _StoreImpl extends Store {
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
    @required DownloadManager downloadManager,
  })  : _user = newUserStore(api, db),
        _podcast = newPodcastStore(api, db),
        _episode = newEpisodeStore(api, db),
        _subscription = newSubscriptionStore(api, db),
        _audioPlayer = newAudioPlayerStore(api, db),
        _playbackPosition = newPlaybackPositionStore(api, db),
        _task = newTaskStore(api, db),
        _audioFile = newAudioFileStore(api, db, downloadManager);

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
