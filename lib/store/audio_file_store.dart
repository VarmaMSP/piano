import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/service/download_manager/download_manager.dart';

AudioFileStore newAudioFileStore(
  Api api,
  Db db,
  DownloadManager downloadManager,
) {
  return _AudioFileStoreImpl(
    api: api,
    db: db,
    downloadManager: downloadManager,
  );
}

abstract class AudioFileStore {
  Future<void> startDownload(Episode episode);
  Future<void> cancelDownload(String episodeId);
  Future<void> syncAllDownloaded(String episodeId);
  Stream<AudioFile> watchByEpisode(String episodeId);
  Future<void> delete(String episodeId);
}

class _AudioFileStoreImpl extends AudioFileStore {
  final Api api;
  final Db db;
  final DownloadManager downloadManager;

  _AudioFileStoreImpl({
    @required this.api,
    @required this.db,
    @required this.downloadManager,
  });

  @override
  Future<void> startDownload(Episode episode) {
    assert(downloadManager != null);

    throw UnimplementedError();
  }

  @override
  Future<void> cancelDownload(String episodeId) {
    assert(downloadManager != null);

    throw UnimplementedError();
  }

  @override
  Future<void> syncAllDownloaded(String episodeId) {
    assert(downloadManager != null);

    throw UnimplementedError();
  }

  @override
  Stream<AudioFile> watchByEpisode(String episodeId) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String episodeId) {
    assert(downloadManager != null);

    throw UnimplementedError();
  }
}
