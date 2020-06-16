import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'sqldb.g.dart';

@UseMoor(tables: [Podcasts, Episodes, AudioTracks])
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
}
