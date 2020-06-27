import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';

import 'db.dart';

class PlaybackPositionDb extends PlaybackPositionStore {
  final Db db;
  final PlaybackPositionStore baseStore;

  PlaybackPositionDb({this.baseStore, this.db});

  @override
  Future<void> save(PlaybackPosition playback) {
    return db.playbackPositionDao.savePlaybackPosition(playback);
  }

  @override
  Stream<PlaybackPosition> watch(String episodeId) {
    return db.playbackPositionDao.watchPlaybackPosition(episodeId);
  }

  @override
  Future<PlaybackPosition> get_(String episodeId) {
    return watch(episodeId).first;
  }

  @override
  Future<void> update(PlaybackPosition playback) {
    return db.playbackPositionDao.setPosition(playback);
  }
}
