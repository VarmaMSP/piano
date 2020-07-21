// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

// Check for storage permission, asks if not granted already
Future<bool> hasStoragePermission() async {
  final permissionStatus = await Permission.storage.request();
  return permissionStatus.isGranted;
}

// Give path to internal storage directory in device
Future<String> getInternalStorageDirectory() async {
  if (Platform.isIOS) {
    final dir = await path_provider.getApplicationDocumentsDirectory();
    return join(dir.path, 'audio');
  }
  if (Platform.isAndroid) {
    final dirs = await path_provider.getExternalStorageDirectories();
    return dirs
        .where((dir) => dir.path.contains('emulated'))
        .map((dir) => join(dir.path, 'audio'))
        .first;
  }
  throw PlatformException(code: '0o0o0', message: 'Uunsupported platform');
}

// Returns a list of paths to external storage directories (Ex SD card).
Future<List<String>> getExternalStorageDirectories() async {
  if (Platform.isIOS) {
    return <String>[];
  }
  if (Platform.isAndroid) {
    final dirs = await path_provider.getExternalStorageDirectories();
    return dirs
        .where((dir) => !dir.path.contains('emulated'))
        .map((dir) => join(dir.path, 'audio'));
  }
  throw PlatformException(code: '0o0o0', message: 'Uunsupported platform');
}

// Returns a new uuid file name for given audioFile url.
String newStorageFileName(String url) {
  final name = Uuid().v4().replaceAll(RegExp(r'[^\w\s\.]+'), '');
  final ext = _getFileExtension(url);
  return '${name}.${ext}';
}

// Deletes given file if exists
Future<void> deleteFile(String filePath) async {
  final file = File(filePath);
  if (await file.exists()) {
    await file.delete();
  }
}

// Create a directory recursively if not exists
Future<void> createDirectory(String dirPath) async {
  await Directory(dirPath).create();
}

// Check if given file exists
Future<bool> checkFileExists(String filePath) {
  return File(filePath).exists();
}

String _getFileExtension(String url) {
  final uri = Uri.parse(url);

  final isMp3 = uri.pathSegments.firstWhere(
        (e) => e.toLowerCase().endsWith('.mp3'),
        orElse: () => null,
      ) !=
      null;
  if (isMp3) {
    return 'mp3';
  }

  final isM4a = uri.pathSegments.firstWhere(
        (e) =>
            e.toLowerCase().endsWith('.m4a') ||
            e.toLowerCase().endsWith('.aac') ||
            e.toLowerCase().endsWith('.mp4') ||
            e.toLowerCase().endsWith('.m4p') ||
            e.toLowerCase().endsWith('.m4r') ||
            e.toLowerCase().endsWith('.3gp'),
        orElse: () => null,
      ) !=
      null;
  if (isM4a) {
    return 'm4a';
  }

  final isOog = uri.pathSegments.firstWhere(
        (e) =>
            e.toLowerCase().endsWith('.ogg') ||
            e.toLowerCase().endsWith('.oga'),
        orElse: () => null,
      ) !=
      null;
  if (isOog) {
    return 'oog';
  }

  // Default to mp3
  return 'mp3';
}
