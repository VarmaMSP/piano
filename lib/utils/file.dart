import 'package:uuid/uuid.dart';

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
