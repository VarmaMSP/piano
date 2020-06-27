import 'package:phenopod/service/sqldb/sqldb.dart';

class Db {
  final SqlDb sqlDb;
  final PodcastDao podcastDao;
  final EpisodeDao episodeDao;
  final PlaybackPositionDao playbackPositionDao;
  final PreferenceDao preferenceDao;
  final AudioTrackDao audioTrackDao;
  final TaskDao taskDao;
  final SubscriptionDao subscriptionDao;

  Db({this.sqlDb})
      : podcastDao = PodcastDao(sqlDb),
        episodeDao = EpisodeDao(sqlDb),
        playbackPositionDao = PlaybackPositionDao(sqlDb),
        preferenceDao = PreferenceDao(sqlDb),
        audioTrackDao = AudioTrackDao(sqlDb),
        taskDao = TaskDao(sqlDb),
        subscriptionDao = SubscriptionDao(sqlDb);

  Future<T> Function<T>(Future<T> Function()) get transaction =>
      sqlDb.transaction;
}
