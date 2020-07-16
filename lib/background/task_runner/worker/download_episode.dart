import 'package:dio/dio.dart';
import 'package:phenopod/store/store.dart';

class DownloadEpisodeWorker {
  final Store store;
  final String taskId;

  final String episodeId;
  final String url;
  final String filepath;

  DownloadEpisodeWorker({
    this.store,
    this.taskId,
    this.episodeId,
    this.url,
    this.filepath,
  });

  Future<void> run() async {
    final dio = Dio();

    try {
      await dio.download(url, filepath, onReceiveProgress: (rec, total) {});
    } catch (err) {
      print(err);
    }
  }
}
