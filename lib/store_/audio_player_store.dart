import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';

AudioPlayerStore newAudioPlayerStore(Api api, Db_ db) {
  return _AudioPlayerStoreImpl(api: api, db: db);
}

abstract class AudioPlayerStore {
  Future<void> saveQueue(Queue queue);
  Future<void> saveSetting(AudioPlayerSetting setting);
  Future<Queue> getQueue();
  Stream<Queue> watchQueue();
  Future<AudioTrack> getNowPlaying();
  Future<AudioPlayerSetting> getSetting();
  Stream<AudioPlayerSetting> watchSetting();
}

class _AudioPlayerStoreImpl extends AudioPlayerStore {
  final Api api;
  final Db_ db;

  _AudioPlayerStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<AudioTrack> getNowPlaying() {
    // TODO: implement getNowPlaying
    throw UnimplementedError();
  }

  @override
  Future<Queue> getQueue() {
    // TODO: implement getQueue
    throw UnimplementedError();
  }

  @override
  Future<AudioPlayerSetting> getSetting() {
    // TODO: implement getSetting
    throw UnimplementedError();
  }

  @override
  Future<void> saveQueue(Queue queue) {
    // TODO: implement saveQueue
    throw UnimplementedError();
  }

  @override
  Future<void> saveSetting(AudioPlayerSetting setting) {
    // TODO: implement saveSetting
    throw UnimplementedError();
  }

  @override
  Stream<Queue> watchQueue() {
    // TODO: implement watchQueue
    throw UnimplementedError();
  }

  @override
  Stream<AudioPlayerSetting> watchSetting() {
    // TODO: implement watchSetting
    throw UnimplementedError();
  }
}
