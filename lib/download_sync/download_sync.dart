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

// Syncs download progress updates from background service to the db
class DownloadSync {
  final Db db;
  final DownloadProgressUpdates downloadProgressUpdates;

  DownloadSync({
    this.db,
    this.downloadProgressUpdates,
  });

  void init() {
    downloadProgressUpdates.init();
  }

  Future<void> dispose() async {
    await downloadProgressUpdates.dispose();
  }
}
