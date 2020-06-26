import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';

class PlaybackPositionDb extends PlaybackPositionStore {
  final PlaybackPositionStore baseStore;
  PlaybackPositionDao _playbackPositionDao;

  PlaybackPositionDb({this.baseStore, SqlDb sqlDb}) {
    _playbackPositionDao = PlaybackPositionDao(sqlDb);
  }

  @override
  Future<void> save(PlaybackPosition playback) {
    return _playbackPositionDao.savePlayback(playback);
  }

  @override
  Future<void> update(PlaybackPosition playback) {
    return _playbackPositionDao.updateProgress(playback);
  }

  @override
  Future<PlaybackPosition> get_(String episodeId) {
    return _playbackPositionDao.getPlayback(episodeId);
  }

  @override
  Stream<PlaybackPosition> watch(String episodeId) {
    return _playbackPositionDao.watchPlayback(episodeId);
  }
}
