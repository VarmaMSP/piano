import 'package:phenopod/service/sqldb/sqldb.dart';

class Db {
  final SqlDb sqlDb;
  final PodcastDao podcastDao;
  final EpisodeDao episodeDao;
  final PlaybackPositionDao playbackPositionDao;
  final PreferenceDao preferenceDao;
  final AudioTrackDao audioTrackDao;
  final SubscriptionDao subscriptionDao;
  final TaskDao taskDao;

  Db({this.sqlDb})
      : podcastDao = PodcastDao(sqlDb),
        episodeDao = EpisodeDao(sqlDb),
        playbackPositionDao = PlaybackPositionDao(sqlDb),
        preferenceDao = PreferenceDao(sqlDb),
        audioTrackDao = AudioTrackDao(sqlDb),
        subscriptionDao = SubscriptionDao(sqlDb),
        taskDao = TaskDao(sqlDb);

  Future<T> Function<T>(Future<T> Function()) get transaction =>
      sqlDb.transaction;
}