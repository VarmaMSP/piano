// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:path/path.dart';
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

  final PublishSubject<Tuple2<int, int>> _progressUpdate =
      PublishSubject<Tuple2<int, int>>();

  DownloadEpisodeWorker({
    @required int taskId,
    @required Store store,
    @required this.episodeId,
    @required this.url,
    @required this.filename,
    @required this.storagePath,
  }) : super(taskId: taskId, store: store) {
    _handleProgressUpdates();
  }

  @override
  Future<bool> shouldExecute() async {
    final audioFile = await store.audioFile.watchByEpisode(episodeId).first;
    return !audioFile.isComplete;
  }

  @override
  Future<void> execute() async {
    final dio = Dio();
    final cancelToken = CancelToken();

    try {
      await fileutils.createDirectory(storagePath);
      await dio.download(
        url,
        join(storagePath, filename),
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) => _progressUpdate.add(
          Tuple2(received, total),
        ),
      );
    } catch (err) {
      if (CancelToken.isCancel(err)) {
        return;
      }
    } finally {
      await markComplete();
    }
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
}
