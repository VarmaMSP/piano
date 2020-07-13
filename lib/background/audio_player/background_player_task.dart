import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:phenopod/background/audio_player/audio_player_controller.dart';
import 'package:phenopod/download_sync/download_sync.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

class BackgroundPlayerTask extends audioservice.BackgroundAudioTask {
  DownloadSync _downloadSync;
  AudioPlayerController _audioPlayerController;

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    final db = await newDb();
    final api = await newApi(appDocDirPath: params['appDocDirPath'] as String);

    _downloadSync = newDownloadSyncForPlayer(db);
    _audioPlayerController = AudioPlayerController(db: db, api: api);

    _downloadSync.init();
    await _audioPlayerController.start();
  }

  @override
  Future<void> onPlay() async {
    await _downloadSync.dispose();
    await _audioPlayerController.play();
  }

  @override
  Future<void> onPause() async {
    await _audioPlayerController.pause();
  }

  @override
  Future<void> onSeekTo(Duration position) async {
    await _audioPlayerController.seekTo(position);
  }

  @override
  Future<void> onFastForward() async {
    await _audioPlayerController.fastForward();
  }

  @override
  Future<void> onRewind() async {
    await _audioPlayerController.rewind();
  }

  @override
  Future<void> onAudioBecomingNoisy() async {
    await _audioPlayerController.pause();
  }

  @override
  Future<void> onClick(audioservice.MediaButton button) async {
    switch (button) {
      case audioservice.MediaButton.media:
        await _audioPlayerController.pauseOrPlay();
        break;
      case audioservice.MediaButton.next:
        break;
      case audioservice.MediaButton.previous:
        break;
    }
  }

  @override
  Future<void> onAudioFocusLost(audioservice.AudioInterruption i) async {
    switch (i) {
      case audioservice.AudioInterruption.pause:
        await _audioPlayerController.pause();
        break;
      case audioservice.AudioInterruption.temporaryPause:
        await _audioPlayerController.pause();
        break;
      case audioservice.AudioInterruption.temporaryDuck:
        break;
      case audioservice.AudioInterruption.unknownPause:
        await _audioPlayerController.pause();
        break;
    }
  }

  @override
  Future<void> onAudioFocusGained(audioservice.AudioInterruption i) async {
    switch (i) {
      case audioservice.AudioInterruption.pause:
        break;
      case audioservice.AudioInterruption.temporaryPause:
        await _audioPlayerController.play();
        break;
      case audioservice.AudioInterruption.temporaryDuck:
        break;
      case audioservice.AudioInterruption.unknownPause:
        break;
    }
  }

  @override
  Future<void> onTaskRemoved() async {
    // await onStop();
  }

  @override
  Future<void> onCustomAction(String name, args) async {
    switch (name) {
      case 'syncQueue':
        await _audioPlayerController.syncQueue();
        break;
      case 'syncNowPlaying':
        await _audioPlayerController.syncNowPlaying();
        break;
      case 'syncSetting':
        await _audioPlayerController.syncSetting();
        break;
    }
  }

  @override
  Future<void> onStop() async {
    await _audioPlayerController.stop();
    await super.onStop();
  }
}
