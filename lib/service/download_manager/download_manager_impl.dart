part of 'download_manager.dart';

class _DownloadManagerImpl extends DownloadManager {
  @override
  Future<bool> hasStoragePermission() async {
    final permissionStatus = await Permission.storage.request();
    return Future.value(permissionStatus.isGranted);
  }

  @override
  Future<String> getStorageDirectory() async {
    final storageDir = await getExternalStorageDirectories(
      type: StorageDirectory.podcasts,
    );

    String dir;
    for (var d in storageDir) {
      if (d.path.contains('emulated')) {
        dir = join(d.path, 'phenopod');
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

  @override
  Future<String> newTask({String url, String dir, String filename}) async {
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: dir,
      fileName: filename,
      showNotification: kDebugMode,
      openFileFromNotification: kDebugMode,
    );
    return taskId;
  }

  @override
  Future<List<String>> getAllDownloaded() async {
    final tasks = await FlutterDownloader.loadTasksWithRawQuery(
      query: 'SELECT * FROM task WHERE status = 3',
    );
    return tasks.map((x) => x.taskId).toList();
  }

  @override
  Future<void> removeTaskWithFile(String taskId) async {
    await FlutterDownloader.remove(taskId: taskId, shouldDeleteContent: true);
  }
}
