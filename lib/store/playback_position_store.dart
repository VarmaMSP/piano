import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';

PlaybackPositionStore newPlaybackPositionStore(Api api, Db db) {
  return _PlaybackPositionStoreImpl(api: api, db: db);
}

abstract class PlaybackPositionStore {
  Future<void> upsert(PlaybackPosition playback);
  Stream<PlaybackPosition> watchByEpisode(String episodeId);
}

class _PlaybackPositionStoreImpl extends PlaybackPositionStore {
  final Api api;
  final Db db;

  _PlaybackPositionStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<void> upsert(PlaybackPosition pos) async {
    await db.playbackPositionDao.upsert(pos);
  }

  @override
  Stream<PlaybackPosition> watchByEpisode(String episodeId) {
    return db.playbackPositionDao.watchByEpisode(episodeId);
  }
}
