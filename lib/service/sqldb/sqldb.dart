import 'dart:collection';
import 'dart:io';
import 'dart:convert';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phenopod/background/moor_server/main.dart';
import 'package:phenopod/model/main.dart';
import 'package:rxdart/rxdart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sqldb.g.dart';

/// Tables
part 'table/podcasts.dart';
part 'table/episodes.dart';
part 'table/audio_tacks.dart';
part 'table/playbacks.dart';
part 'table/preferences.dart';

/// Daos
part 'dao/podcast_dao.dart';
part 'dao/playback_dao.dart';
part 'dao/preference_dao.dart';
part 'dao/queue_dao.dart';

Future<SqlDb> newSqlDb() async {
  final moorIsolate = await getMoorIsolate();
  final databaseConnection = await moorIsolate.connect();
  return SqlDb.connect(databaseConnection);
}

@UseMoor(
  tables: [
    Podcasts,
    Episodes,
    AudioTracks,
    Playbacks,
    Preferences,
  ],
  daos: [
    PodcastDao,
    QueueDao,
    PlaybackDao,
    PreferenceDao,
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
        },
      );
}
