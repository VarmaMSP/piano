import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';

PlaybackPositionStore newPlaybackPositionStore(Api api, Db_ db) {
  return _PlaybackPositionStoreImpl(api: api, db: db);
}

abstract class PlaybackPositionStore {
  Future<void> save(PlaybackPosition playback);
  Future<void> update(PlaybackPosition playback);
  Future<PlaybackPosition> get_(String episodeId);
  Stream<PlaybackPosition> watch(String episodeId);
}

class _PlaybackPositionStoreImpl extends PlaybackPositionStore {
  final Api api;
  final Db_ db;

  _PlaybackPositionStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<PlaybackPosition> get_(String episodeId) {
    // TODO: implement get_
    throw UnimplementedError();
  }

  @override
  Future<void> save(PlaybackPosition playback) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<void> update(PlaybackPosition playback) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<PlaybackPosition> watch(String episodeId) {
    // TODO: implement watch
    throw UnimplementedError();
  }
}
