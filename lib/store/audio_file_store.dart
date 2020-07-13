import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

AudioFileStore newAudioFileStore(Api api, Db db) {
  return _AudioFileStoreImpl(api: api, db: db);
}

abstract class AudioFileStore {
  Future<void> save(AudioFile audioFile);
  Stream<AudioFile> watchByEpisode(String episodeId);
  Future<void> updateProgress(DownloadProgress downloadProgress);
  Future<void> delete(String episodeId);
}

class _AudioFileStoreImpl extends AudioFileStore {
  final Api api;
  final Db db;

  _AudioFileStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<void> save(AudioFile audioFile) {
    throw UnimplementedError();
  }

  @override
  Stream<AudioFile> watchByEpisode(String episodeId) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProgress(DownloadProgress downloadProgress) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String episodeId) {
    throw UnimplementedError();
  }
}
