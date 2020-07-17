import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import 'worker.dart';

class DownloadEpisodeWorker extends Worker {
  final String episodeId;
  final String url;
  final String filepath;

  final PublishSubject<Tuple2<int, int>> _progressUpdate =
      PublishSubject<Tuple2<int, int>>();

  DownloadEpisodeWorker({
    @required int taskId,
    @required Store store,
    @required this.episodeId,
    @required this.url,
    @required this.filepath,
  }) : super(taskId: taskId, store: store) {
    _handleProgressUpdates();
  }

  void _handleProgressUpdates() {
    _progressUpdate.stream.sampleTime(Duration(seconds: 1)).listen((e) async {
      final received = e.item1;
      final total = e.item2;

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
    });
  }

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
        onReceiveProgress: (received, total) => _progressUpdate.add(
          Tuple2(received, total),
        ),
      );
    } catch (err) {
      if (CancelToken.isCancel(err)) {
        return;
      }
    }
  }
}
