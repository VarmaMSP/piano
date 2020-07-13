import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:phenopod/download_sync/progress_updates.dart';
import 'package:tuple/tuple.dart';

void downloadCallback(String taskId, DownloadTaskStatus status, int progress) {
  final uiSendPort = IsolateNameServer.lookupPortByName(
    UIDownloadProgressUpdates.sendPortMapping,
  );
  if (uiSendPort != null) {
    return uiSendPort.send(Tuple3(taskId, status, progress));
  }

  final playerSendPort = IsolateNameServer.lookupPortByName(
    PlayerDownloadProgressUpdates.sendPortMapping,
  );
  if (playerSendPort != null) {
    return playerSendPort.send(Tuple3(taskId, status, progress));
  }
}

Future<void> initDownloader() async {
  await FlutterDownloader.initialize(debug: true);
  FlutterDownloader.registerCallback(downloadCallback);
}
