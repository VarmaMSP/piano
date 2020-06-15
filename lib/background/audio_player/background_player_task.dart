import 'package:audio_service/audio_service.dart' as audioservice;
import 'audio_player.dart';

class BackgroundPlayerTask extends audioservice.BackgroundAudioTask {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    await _audioPlayer.start();
  }

  @override
  Future<void> onPlayMediaItem(audioservice.MediaItem mediaItem) async {
    await _audioPlayer.playMediaItem(mediaItem);
  }

  @override
  Future<void> onPlay() async {
    await _audioPlayer.play();
  }

  @override
  Future<void> onPause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> onSeekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> onClick(audioservice.MediaButton button) async {
    await _audioPlayer.pauseOrPlay();
  }

  @override
  Future<void> onAudioBecomingNoisy() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> onCustomAction(String name, args) async {}

  @override
  Future<void> onStop() async {
    await _audioPlayer.stop();
    await super.onStop();
  }
}
