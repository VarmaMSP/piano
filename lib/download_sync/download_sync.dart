import 'package:phenopod/service/db/db.dart';

import 'progress_updates.dart';

DownloadSync newDownloadSyncForUI(Db db) {
  return DownloadSync(
    db: db,
    downloadProgressUpdates: UIDownloadProgressUpdates(),
  );
}

DownloadSync newDownloadSyncForPlayer(Db db) {
  return DownloadSync(
    db: db,
    downloadProgressUpdates: PlayerDownloadProgressUpdates(),
  );
}

/// Syncs download progress updates from background service to the db
///
/// This is supposed to be used in both audio and ui isolate so that
/// audio player can play from disk the moment the download is complete
/// even after the ui is closed.
class DownloadSync {
  final Db db;
  final DownloadProgressUpdates downloadProgressUpdates;

  DownloadSync({
    this.db,
    this.downloadProgressUpdates,
  });

  void init() {
    downloadProgressUpdates.init();
    downloadProgressUpdates.progressUpdates
        .listen(db.audioFileDao.updateProgress);
  }

  Future<void> dispose() async {
    await downloadProgressUpdates.dispose();
  }
}
