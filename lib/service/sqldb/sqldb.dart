import 'dart:collection';
import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phenopod/background/moor_server/main.dart';
import 'package:phenopod/model/main.dart';
import 'package:rxdart/rxdart.dart';

part 'sqldb.g.dart';

/// Tables
part 'table/podcasts.dart';
part 'table/episodes.dart';
part 'table/audio_tacks.dart';
part 'table/audio_player_snapshots.dart';
part 'table/playbacks.dart';

/// Daos
part 'dao/podcast_dao.dart';
part 'dao/audio_player_dao.dart';
part 'dao/playback_dao.dart';

Future<SqlDb> newSqlDb() async {
  final moorIsolate = await getMoorIsolate();
  final databaseConnection = await moorIsolate.connect();
  return SqlDb.connect(databaseConnection);
}

@UseMoor(
  tables: [Podcasts, Episodes, AudioTracks, AudioPlayerSnapshots, Playbacks],
  daos: [PodcastDao, AudioPlayerDao, PlaybackDao],
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
