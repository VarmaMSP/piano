import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';
import 'package:rxdart/rxdart.dart';

abstract class DownloadProgressUpdates {
  final ReceivePort _receivePort = ReceivePort();

  final BehaviorSubject<DownloadProgress> _progressUpdate =
      BehaviorSubject<DownloadProgress>();

  @mustCallSuper
  void init() {
    _receivePort.listen(
      (m) => _progressUpdate.add(DownloadProgress.fromDownloaderUpdate(m)),
    );
  }

  Stream<DownloadProgress> get progressUpdates => _progressUpdate.stream;

  @mustCallSuper
  Future<void> dispose() async {
    await _progressUpdate.close();
  }
}

class UIDownloadProgressUpdates extends DownloadProgressUpdates {
  static const String sendPortMapping = 'UI_DOWNLOADER_SEND_PORT';

  @override
  void init() {
    IsolateNameServer.removePortNameMapping(sendPortMapping);
    super.init();
  }

  @override
  Future<void> dispose() async {
    IsolateNameServer.removePortNameMapping(sendPortMapping);
    await super.dispose();
  }
}

class PlayerDownloadProgressUpdates extends DownloadProgressUpdates {
  static const String sendPortMapping = 'PLAYER_DOWNLOADER_SEND_PORT';

  @override
  void init() {
    IsolateNameServer.removePortNameMapping(sendPortMapping);
    super.init();
  }

  @override
  Future<void> dispose() async {
    IsolateNameServer.removePortNameMapping(sendPortMapping);
    await super.dispose();
  }
}
