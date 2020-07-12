import 'package:phenopod/background/downloader/main.dart';
import 'package:phenopod/background/downloader/updates.dart';

part 'download_service_impl.dart';

Future<void> initBackgroundService() async {
  await initDownloader();
}

DownloadService newDownloadServiceForUI() {
  return _DownloadServiceImpl(
    downloadProgressUpdates: UIDownloadProgressUpdates(),
  );
}

DownloadService newDownloadServiceForPlayer() {
  return _DownloadServiceImpl(
    downloadProgressUpdates: PlayerDownloadProgressUpdates(),
  );
}

abstract class DownloadService {
  /// Init resources
  void init();

  /// Dispose resources
  Future<void> dispose();
}
