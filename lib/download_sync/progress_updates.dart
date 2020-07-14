import 'dart:isolate';
import 'dart:ui';

import 'package:phenopod/model/main.dart';
import 'package:rxdart/rxdart.dart';

abstract class DownloadProgressUpdates {
  final String portNameMapping;
  final ReceivePort _receivePort = ReceivePort();

  final BehaviorSubject<DownloadProgress> _progressUpdate =
      BehaviorSubject<DownloadProgress>();

  DownloadProgressUpdates({this.portNameMapping});

  void init() {
    IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      portNameMapping,
    );
    _receivePort.listen(
      (m) => _progressUpdate.add(DownloadProgress.fromDownloaderUpdate(m)),
    );
  }

  Stream<DownloadProgress> get progressUpdates => _progressUpdate.stream;

  Future<void> dispose() async {
    IsolateNameServer.removePortNameMapping(portNameMapping);
    await _progressUpdate.close();
  }
}

class UIDownloadProgressUpdates extends DownloadProgressUpdates {
  static const String sendPortMapping = 'UI_DOWNLOADER_SEND_PORT';

  UIDownloadProgressUpdates() : super(portNameMapping: sendPortMapping);
}

class PlayerDownloadProgressUpdates extends DownloadProgressUpdates {
  static const String sendPortMapping = 'PLAYER_DOWNLOADER_SEND_PORT';

  PlayerDownloadProgressUpdates() : super(portNameMapping: sendPortMapping);
}
