// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

AudioFileStore newAudioFileStore(Api api, Db db) {
  return _AudioFileStoreImpl(api: api, db: db);
}

abstract class AudioFileStore {
  Future<void> save(AudioFile audioFile);
  Stream<AudioFile> watchByEpisode(String episodeId);
  Future<void> updateDownloadProgress(DownloadProgress progress);
  Future<void> deleteByEpisode(String episodeId);
}

class _AudioFileStoreImpl extends AudioFileStore {
  final Api api;
  final Db db;

  _AudioFileStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<void> save(AudioFile audioFile) async {
    await db.audioFileDao.save(audioFile);
  }

  @override
  Stream<AudioFile> watchByEpisode(String episodeId) {
    return db.audioFileDao.watchByEpisode(episodeId);
  }

  @override
  Future<void> updateDownloadProgress(DownloadProgress progress) async {
    await db.audioFileDao.updateProgress(progress);
  }

  @override
  Future<void> deleteByEpisode(String episodeId) async {
    await db.audioFileDao.deleteByEpisode(episodeId);
  }
}
