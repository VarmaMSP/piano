import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

enum DownloadState {
  none,
  queued,
  downloading,
  failed,
  cancelled,
  paused,
  downloaded,
}

class DownloadProgress {
  final String id;
  final DownloadState state;
  final double percentage;

  DownloadProgress(this.id, this.state, this.percentage);
}

abstract class DownloadProgressUpdates {
  final ReceivePort _receivePort = ReceivePort();
  final BehaviorSubject<DownloadProgress> _progressUpdate =
      BehaviorSubject<DownloadProgress>();

  @mustCallSuper
  void init() {
    _handleUpdates();
  }

  void _handleUpdates() {
    _receivePort.listen((message) {
      final m = message as Tuple3<String, DownloadTaskStatus, int>;
      final id = m.item1;
      final status = m.item2;
      final progress = m.item3;

      var state = DownloadState.none;
      if (status == DownloadTaskStatus.enqueued) {
        state = DownloadState.queued;
      } else if (status == DownloadTaskStatus.canceled) {
        state = DownloadState.cancelled;
      } else if (status == DownloadTaskStatus.complete) {
        state = DownloadState.downloaded;
      } else if (status == DownloadTaskStatus.running) {
        state = DownloadState.downloading;
      } else if (status == DownloadTaskStatus.failed) {
        state = DownloadState.failed;
      } else if (status == DownloadTaskStatus.paused) {
        state = DownloadState.paused;
      }

      _progressUpdate.add(DownloadProgress(id, state, progress.toDouble()));
    });
  }

  Stream<DownloadProgress> get progressUpdate => _progressUpdate.stream;

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
