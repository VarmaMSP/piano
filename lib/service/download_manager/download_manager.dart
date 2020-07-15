import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phenopod/background/downloader/main.dart';

part 'download_manager_impl.dart';

Future<DownloadManager> newDownloadManager() async {
  await initDownloader();
  return _DownloadManagerImpl();
}

abstract class DownloadManager {
  // Check if user has already granted storage permission
  // else ask permission explictly.
  Future<bool> hasStoragePermission();

  // Get storage directory for audio files
  Future<String> getStorageDirectory();

  // Create new download task and return taskId
  Future<String> newTask({String url, String dir, String filename});

  // Cancel task wih given task id
  Future<void> removeTaskWithFile(String taskId);
}
