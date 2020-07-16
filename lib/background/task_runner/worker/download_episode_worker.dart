import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';

import 'worker.dart';

class DownloadEpisodeWorker extends Worker {
  final String episodeId;
  final String url;
  final String filepath;

  DownloadEpisodeWorker({
    @required int taskId,
    @required Store store,
    @required this.episodeId,
    @required this.url,
    @required this.filepath,
  }) : super(taskId: taskId, store: store);

  @override
  Future<bool> shouldExecute() async {
    return true;
  }

  @override
  Future<void> execute() async {
    final dio = Dio();
    final cancelToken = CancelToken();

    try {
      await dio.download(
        url,
        filepath,
        cancelToken: cancelToken,
        onReceiveProgress: _updateProgress,
      );
    } catch (err) {
      if (CancelToken.isCancel(err)) {
        return;
      }
    }
  }

  Future<void> _updateProgress(int received, int total) async {
    print('$received / $total');
    if (total > 0) {
      await store.audioFile.updateDownloadProgress(
        DownloadProgress(
          episodeId: episodeId,
          downloadState: DownloadState.downloading,
          downloadPercentage: received / total,
        ),
      );
    }
  }
}
