import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:phenopod/background/audio_player/audio_player_controller.dart';
import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';

class BackgroundPlayerTask extends audioservice.BackgroundAudioTask {
  AudioPlayerController _audioPlayerController;

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    _audioPlayerController = AudioPlayerController(
      sqlDb: await newSqlDb(),
      httpClient: await newHttpClient(
        appDocDirPath: params['appDocDirPath'] as String,
      ),
    );

    await _audioPlayerController.start();
  }

  @override
  Future<void> onPlay() async {
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
  Future<void> onClick(audioservice.MediaButton button) async {
    await _audioPlayerController.pauseOrPlay();
  }

  @override
  Future<void> onAudioBecomingNoisy() async {
    await _audioPlayerController.pause();
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
