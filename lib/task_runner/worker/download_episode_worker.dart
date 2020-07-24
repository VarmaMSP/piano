// Flutter imports:

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/file.dart' as fileutils;
import 'worker.dart';

class DownloadEpisodeWorker extends Worker {
  final String episodeId;
  final String url;
  final String filename;
  final String storagePath;

  final Dio dio = Dio();
  final CancelToken cancelToken = CancelToken();
  final PublishSubject<Tuple2<int, int>> _progressUpdates =
      PublishSubject<Tuple2<int, int>>();

  StreamSubscription<dynamic> _cancellationSubscription;
  StreamSubscription<dynamic> _progressUpdatesSubscription;

  DownloadEpisodeWorker({
    @required int taskId,
    @required Db db,
    @required Api api,
    @required Store store,
    @required this.episodeId,
    @required this.url,
    @required this.filename,
    @required this.storagePath,
  }) : super(taskId: taskId, db: db, api: api, store: store) {
    // Cancellation subscription
    _cancellationSubscription = store.task
        .watchById(taskId)
        .where((e) => e == null)
        .listen((_) => cancelToken.cancel());

    // Handle progress updates
    _progressUpdatesSubscription = _progressUpdates.stream
        .sampleTime(Duration(seconds: 1, milliseconds: 500))
        .listen((e) => _updateDownloadProgress(e.item1, e.item2));
  }

  @override
  Future<bool> shouldExecute() async {
    final audioFile = await store.audioFile.watchByEpisode(episodeId).first;
    return audioFile != null && !audioFile.isComplete;
  }

  @override
  Future<void> execute() async {
    try {
      await fileutils.createDirectory(storagePath);
      await dio.download(
        url,
        join(storagePath, filename),
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) => _progressUpdates.add(
          Tuple2(received, total),
        ),
      );
      await _cancellationSubscription.cancel();
      await deleteTask();
    } on DioError catch (err) {
      if (!CancelToken.isCancel(err)) {
        //FIXME: handle failure case
        await deleteTask();
      }
    }
  }

  @override
  Future<void> dispose() async {
    await _progressUpdates.close();
    await _cancellationSubscription?.cancel();
    await _progressUpdatesSubscription.cancel();
  }

  Future<void> _updateDownloadProgress(int received, int total) async {
    if (total > 0) {
      await store.audioFile.updateDownloadProgress(
        DownloadProgress(
          episodeId: episodeId,
          downloadState: received == total
              ? DownloadState.downloaded
              : DownloadState.downloading,
          downloadPercentage: received / total,
        ),
      );
    }
  }
}
