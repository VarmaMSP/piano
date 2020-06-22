import 'package:phenopod/model/queue.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';

class QueueDb extends QueueStore {
  final QueueStore baseStore;
  QueueDao _queueDao;

  QueueDb({this.baseStore, SqlDb sqlDb}) {
    _queueDao = QueueDao(sqlDb);
  }

  @override
  Future<void> save(Queue queue) {
    return _queueDao.saveQueue(queue);
  }

  @override
  Future<Queue> get_() {
    return _queueDao.getQueue();
  }

  @override
  Stream<Queue> watch() {
    return _queueDao.watchQueue();
  }

  @override
  Future<AudioTrack> getNowPlaying() {
    return _queueDao.getNowPlaying();
  }
}
