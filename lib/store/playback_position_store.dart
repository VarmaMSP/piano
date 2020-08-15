// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/alarm_service/alarm_service.dart';
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/db/db.dart';

PlaybackPositionStore newPlaybackPositionStore(
  Api api,
  Db db, [
  AlarmService alarmService,
  bool lazyQueries,
]) {
  return _PlaybackPositionStoreImpl(
    api: api,
    db: db,
    alarmService: alarmService,
    lazyQueries: lazyQueries,
  );
}

abstract class PlaybackPositionStore {
  Future<void> upsert(PlaybackPosition playback);
  PlaybackPosition getByEpisode(String episodeId);
  Stream<PlaybackPosition> watchByEpisode(String episodeId);
}

class _PlaybackPositionStoreImpl extends PlaybackPositionStore {
  final Api api;
  final Db db;
  final AlarmService alarmService;
  final bool lazyQueries;

  /// Keep entire table in memory
  final BehaviorSubject<Map<String, PlaybackPosition>> _byEpisodeId =
      BehaviorSubject<Map<String, PlaybackPosition>>.seeded({});

  _PlaybackPositionStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
    @required this.lazyQueries,
  }) {
    if (lazyQueries) {
      db.playbackPositionDao.watchAll().listen((positions) {
        _byEpisodeId.add({for (var pos in positions) pos.episodeId: pos});
      });
    }
  }

  @override
  Future<void> upsert(PlaybackPosition pos) async {
    await db.playbackPositionDao.upsert(pos);
  }

  @override
  PlaybackPosition getByEpisode(String episodeId) {
    if (lazyQueries) {
      return _byEpisodeId.value[episodeId];
    }
    throw ('Lazy Queries not enabled');
  }

  @override
  Stream<PlaybackPosition> watchByEpisode(String episodeId) {
    return lazyQueries
        ? _byEpisodeId.map((byEpisodeId) => byEpisodeId[episodeId])
        : db.playbackPositionDao.watchAll();
  }
}
