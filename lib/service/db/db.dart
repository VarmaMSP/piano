import 'dart:collection';
import 'dart:io';
import 'dart:convert';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phenopod/background/moor_server/main.dart';
import 'package:phenopod/model/main.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'db.g.dart';

/// Tables
part 'table/podcasts.dart';
part 'table/episodes.dart';
part 'table/audio_tacks.dart';
part 'table/playback_positions.dart';
part 'table/preferences.dart';
part 'table/subscriptions.dart';
part 'table/subscription_filters.dart';
part 'table/tasks.dart';

/// Daos
part 'dao/podcast_dao.dart';
part 'dao/episode_dao.dart';
part 'dao/playback_position_dao.dart';
part 'dao/preference_dao.dart';
part 'dao/audio_track_dao.dart';
part 'dao/subscription_dao.dart';
part 'dao/task_dao.dart';

Future<Db> newDb() async {
  final moorIsolate = await getMoorIsolate();
  final databaseConnection = await moorIsolate.connect();
  final sqldb = SqlDb.connect(databaseConnection);
  return Db(sqldb);
}

class Db {
  final SqlDb sqlDb;
  final PodcastDao podcastDao;
  final EpisodeDao episodeDao;
  final PlaybackPositionDao playbackPositionDao;
  final PreferenceDao preferenceDao;
  final AudioTrackDao audioTrackDao;
  final SubscriptionDao subscriptionDao;
  final TaskDao taskDao;

  Db(this.sqlDb)
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

@UseMoor(
  tables: [
    Podcasts,
    Episodes,
    AudioTracks,
    PlaybackPositions,
    Preferences,
    Subscriptions,
    SubscriptionFilters,
    Tasks,
  ],
  daos: [
    PodcastDao,
    EpisodeDao,
    AudioTrackDao,
    PlaybackPositionDao,
    PreferenceDao,
    SubscriptionDao,
    TaskDao
  ],
)
class SqlDb extends _$SqlDb {
  SqlDb()
      : super(LazyDatabase(() async {
          final dbFolder = await getApplicationDocumentsDirectory();
          final file = File(join(dbFolder.path, 'db.sqlite'));
          return VmDatabase(file);
        }));

  SqlDb.connect(DatabaseConnection connection) : super.connect(connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await customStatement('PRAGMA temp_store = 2');
        },
      );
}
