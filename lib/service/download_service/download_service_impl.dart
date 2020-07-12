part of 'download_service.dart';

class _DownloadServiceImpl extends DownloadService {
  final DownloadProgressUpdates downloadProgressUpdates;

  _DownloadServiceImpl({this.downloadProgressUpdates});

  @override
  void init() {
    downloadProgressUpdates.init();
  }

  @override
  Future<void> dispose() async {
    await downloadProgressUpdates.dispose();
  }
}
