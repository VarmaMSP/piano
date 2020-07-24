// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/alarm_service/alarm_service.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/utils/file.dart' as fileutils;
import 'package:phenopod/utils/file.dart';

AudioFileStore newAudioFileStore(Api api, Db db, [AlarmService alarmService]) {
  return _AudioFileStoreImpl(api: api, db: db, alarmService: alarmService);
}

abstract class AudioFileStore {
  Future<void> download({
    @required Episode episode,
    @required Podcast podcast,
    @required String storagePath,
  });
  Stream<AudioFile> watchByEpisode(String episodeId);
  Stream<List<AudioFile>> watchAll();
  Stream<DownloadProgress> watchDownloadProgress(String episodeId);
  Future<void> updateDownloadProgress(DownloadProgress progress);
  Future<void> deleteByEpisode(String episodeId);
}

class _AudioFileStoreImpl extends AudioFileStore {
  final Api api;
  final Db db;
  final AlarmService alarmService;

  _AudioFileStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
  });

  @override
  Future<void> download({
    @required Episode episode,
    @required Podcast podcast,
    @required String storagePath,
  }) async {
    final audioFile = await watchByEpisode(episode.id).first;
    if (audioFile != null && audioFile.downloadState != DownloadState.failed) {
      return;
    }

    await db.transaction(
      () async {
        final filename = fileutils.newStorageFileName(episode.mediaUrl);
        final taskId = await db.taskDao.saveTask(
          Task.highPriority(
            taskType: TaskType.downloadEpisode(
              episodeId: episode.id,
              url: episode.mediaUrl,
              filename: filename,
              storagePath: storagePath,
            ),
          ),
        );

        await db.audioFileDao.save(
          AudioFile.init(
            episode: episode,
            podcast: podcast,
            filename: filename,
            storagePath: storagePath,
            downloadTaskId: taskId,
          ),
        );
      },
    );

    await alarmService?.scheduleTaskRunner();
  }

  @override
  Stream<AudioFile> watchByEpisode(String episodeId) {
    return db.audioFileDao.watchFileByEpisode(episodeId);
  }

  @override
  Stream<List<AudioFile>> watchAll() {
    return db.audioFileDao.watchAllFiles();
  }

  @override
  Stream<DownloadProgress> watchDownloadProgress(String episodeId) {
    return db.audioFileDao.watchProgressByEpisode(episodeId);
  }

  @override
  Future<void> updateDownloadProgress(DownloadProgress progress) async {
    await db.audioFileDao.updateProgress(progress);
  }

  @override
  Future<void> deleteByEpisode(String episodeId) async {
    final audioFile = await db.audioFileDao.watchFileByEpisode(episodeId).first;
    if (audioFile != null) {
      await db.transaction(() async {
        await db.taskDao.deleteTask(audioFile.downloadTaskId);
        await db.audioFileDao.deleteByEpisode(episodeId);
      });
      // It takes time for deletion to reflect in the background, so
      // apply a slight delay to avoid download errors
      Future.delayed(
        Duration(seconds: 1),
        () => deleteFile(audioFile.filepath),
      );
    }
  }
}
