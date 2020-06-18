import 'package:phenopod/model/audio_player.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';

class AudioPlayerDb extends AudioPlayerStore {
  final AudioPlayerStore baseStore;
  AudioPlayerDao _audioPlayerDao;

  AudioPlayerDb({this.baseStore, SqlDb sqlDb}) {
    _audioPlayerDao = AudioPlayerDao(sqlDb);
  }

  @override
  Stream<AudioPlayerSnapshot> getSnapshot() {
    return _audioPlayerDao.getSnapshot();
  }

  @override
  Future<void> saveSnapshot(AudioPlayerSnapshot snapshot) {
    return _audioPlayerDao.saveSnapshot(snapshot);
  }
}
