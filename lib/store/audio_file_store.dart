import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

AudioFileStore newAudioFileStore(Api api, Db db) {
  return _AudioFileStoreImpl(api: api, db: db);
}

abstract class AudioFileStore {
  Future<void> startDownload(Episode episode);
  Future<void> cancelDownload(String episodeId);
  Stream<AudioFile> watchByEpisode(String episodeId);
  Future<void> syncAllDownloaded();
}

class _AudioFileStoreImpl extends AudioFileStore {
  final Api api;
  final Db db;

  _AudioFileStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<void> startDownload(Episode episode) async {
    // final audioFile = await watchByEpisode(episode.id).first;
    // if (!await downloadManager.hasStoragePermission() &&
    //     audioFile != null &&
    //     audioFile.isDownloaded &&
    //     audioFile.isDownloading) {
    //   return;
    // }
    // // Purge file, in future give user ability to resume tasks
    // if (audioFile != null) {
    //   await downloadManager.removeTaskWithFile(audioFile.taskId);
    // }

    // final dir = await downloadManager.getStorageDirectory();
    // final filename = newStorageFileName(episode.mediaUrl);
    // final taskId = await downloadManager.newTask(
    //   url: episode.mediaUrl,
    //   dir: dir,
    //   filename: filename,
    // );
    // await db.audioFileDao.save(AudioFile.init(
    //   episode: episode,
    //   directory: dir,
    //   filename: filename,
    //   taskId: taskId,
    // ));
  }

  @override
  Future<void> cancelDownload(String episodeId) async {
    final audioFile = await watchByEpisode(episodeId).first;
    if (audioFile != null) {
      // await downloadManager.removeTaskWithFile(audioFile.taskId);
      // await db.audioFileDao.deleteByEpisode(episodeId);
    }
  }

  @override
  Stream<AudioFile> watchByEpisode(String episodeId) {
    return db.audioFileDao.watchByEpisode(episodeId);
  }

  @override
  Future<void> syncAllDownloaded() async {
    // final taskIds = await downloadManager.getAllDownloaded();
    // await db.audioFileDao.setAsDownloaded(taskIds);
  }
}
