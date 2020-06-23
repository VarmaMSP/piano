import 'package:phenopod/model/playback.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';

class PlaybackDb extends PlaybackStore {
  final PlaybackStore baseStore;
  PlaybackDao _playbackDao;

  PlaybackDb({this.baseStore, SqlDb sqlDb}) {
    _playbackDao = PlaybackDao(sqlDb);
  }

  @override
  Future<void> save(Playback playback) {
    return _playbackDao.savePlayback(playback);
  }

  @override
  Future<void> updateProgress(Playback playback) {
    return _playbackDao.updateProgress(playback);
  }

  @override
  Future<Playback> get_(String episodeId) {
    return _playbackDao.getPlayback(episodeId);
  }

  @override
  Stream<Playback> watch(String episodeId) {
    return _playbackDao.watchPlayback(episodeId);
  }
}
