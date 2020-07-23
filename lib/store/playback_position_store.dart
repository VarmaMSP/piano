// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/alarm_service/alarm_service.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

PlaybackPositionStore newPlaybackPositionStore(
  Api api,
  Db db, [
  AlarmService alarmService,
]) {
  return _PlaybackPositionStoreImpl(
    api: api,
    db: db,
    alarmService: alarmService,
  );
}

abstract class PlaybackPositionStore {
  Future<void> upsert(PlaybackPosition playback);
  Stream<PlaybackPosition> watchByEpisode(String episodeId);
}

class _PlaybackPositionStoreImpl extends PlaybackPositionStore {
  final Api api;
  final Db db;
  final AlarmService alarmService;

  _PlaybackPositionStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
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
