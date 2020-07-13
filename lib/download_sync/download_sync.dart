import 'package:phenopod/service/db/db.dart';

import 'progress_updates.dart';

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
