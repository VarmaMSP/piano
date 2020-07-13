part of 'download_service.dart';

class _DownloadServiceImpl extends DownloadService {
  final DownloadProgressUpdates downloadProgressUpdates;

  _DownloadServiceImpl({this.downloadProgressUpdates});

  @override
  void init() {
    downloadProgressUpdates.init();
  }

  @override
  Future<void> downloadEpisode(Episode episode) {
    throw UnimplementedError();
  }

  @override
  Stream<DownloadProgress> watchProgressByEpisode(String episodeId) {
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() async {
    await downloadProgressUpdates.dispose();
  }
}
