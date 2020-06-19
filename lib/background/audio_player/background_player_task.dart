import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:phenopod/background/audio_player/audio_player_controller.dart';
import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/store/store_impl.dart';
import 'audio_player.dart';

class BackgroundPlayerTask extends audioservice.BackgroundAudioTask {
  Store _store;
  AudioPlayer _audioPlayer;
  AudioPlayerController _audioPlayerController;

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    _store = newStore(
      await newSqlDb(),
      await newHttpClient(appDocDirPath: params['appDocDirPath'] as String),
    );
    _audioPlayer = AudioPlayer();
    _audioPlayerController = AudioPlayerController(_store, _audioPlayer);

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
      case 'playTrack':
        await _audioPlayerController.playTrack();
        break;
      default:
        break;
    }
  }

  @override
  Future<void> onStop() async {
    await _audioPlayer.stop();
    await super.onStop();
  }
}
