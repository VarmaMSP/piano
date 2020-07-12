import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:tuple/tuple.dart';

import 'updates.dart';

void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final uiSendPort = IsolateNameServer.lookupPortByName(
    UIDownloadProgressUpdates.sendPortMapping,
  );
  if (uiSendPort != null) {
    return uiSendPort.send(Tuple3(id, status, progress));
  }

  final playerSendPort = IsolateNameServer.lookupPortByName(
    PlayerDownloadProgressUpdates.sendPortMapping,
  );
  if (playerSendPort != null) {
    return playerSendPort.send(Tuple3(id, status, progress));
  }
}

Future<void> initDownloader() async {
  await FlutterDownloader.initialize(debug: true);
  FlutterDownloader.registerCallback(downloadCallback);
}
