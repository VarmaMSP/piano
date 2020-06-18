import 'dart:collection';
import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phenopod/model/main.dart';
import 'package:rxdart/rxdart.dart';

part 'sqldb.g.dart';

/// Tables
part 'table/podcast_table.dart';
part 'table/episode_table.dart';
part 'table/audio_tack_table.dart';
part 'table/audio_player_snapshot_table.dart';

/// Daos
part 'dao/podcast_dao.dart';
part 'dao/audio_player_dao.dart';

@UseMoor(
  tables: [Podcasts, Episodes, AudioTracks, AudioPlayerSnapshots],
  daos: [PodcastDao, AudioPlayerDao],
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
