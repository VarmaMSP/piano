import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

Future<bool> hasStoragePermission() async {
  final permissionStatus = await Permission.storage.request();
  return Future.value(permissionStatus.isGranted);
}

Future<String> getStorageDirectory() async {
  final storageDir = await getExternalStorageDirectories(
    type: StorageDirectory.podcasts,
  );

  String dir;
  for (var d in storageDir) {
    if (d.path.contains('emulated')) {
      dir = d.path;
    } else {
      // In Future give user an option to choose external storage
      // return join(d.absolute.path, 'phenopod');
    }
  }
  dir ??= join(storageDir[storageDir.length - 1].path, 'phenopod');

  // Ensure the directory exists
  Directory(dir).createSync();

  return dir;
}

String newStorageFileName(String url) {
  final name = Uuid().v4().replaceAll(RegExp(r'[^\w\s\.]+'), '');
  final ext = _getFileExtension(url);
  return '${name}.${ext}';
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
