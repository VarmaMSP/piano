import 'package:phenopod/model/podcast.dart';
import 'package:phenopod/services/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';

class PodcastDb extends PodcastStore {
  final PodcastStore baseStore;
  PodcastDao _podcastDao;

  PodcastDb({this.baseStore, SqlDb sqlDb}) {
    _podcastDao = PodcastDao(sqlDb);
  }

  @override
  Future<Podcast> get(String podcastId) {
    return baseStore.get(podcastId);
  }

  @override
  Future<PodcastScreenData> getScreenData(String podcastUrlParam) async {
    var podcastScreenData = await _podcastDao.getScreenData(podcastUrlParam);
    if (podcastScreenData == null) {
      podcastScreenData = await baseStore.getScreenData(podcastUrlParam);
      await _podcastDao.insertScreenData(podcastScreenData);
    }

    return podcastScreenData;
  }
}
