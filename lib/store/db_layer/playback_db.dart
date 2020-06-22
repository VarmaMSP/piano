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
  Future<Playback> getByEpisode(String episodeId) {
    return _playbackDao.getPlayback(episodeId);
  }

  @override
  Stream<Playback> watchByEpisode(String episodeId) {
    return _playbackDao.watchPlayback(episodeId);
  }
}
