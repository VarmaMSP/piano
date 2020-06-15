import 'package:equatable/equatable.dart';
// import 'package:moor/moor.dart';
// import 'package:moor_ffi/moor_ffi.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
// import 'package:moor/isolate.dart';
// import 'dart:io';

import 'podcast.dart';

// part 'curation.g.dart';

class Curation extends Equatable {
  const Curation({
    this.id,
    this.title,
    this.podcasts,
  });

  factory Curation.fromJson(Map<String, dynamic> json) {
    return Curation(
      id: json['title'],
      title: json['title'],
      podcasts: (json['podcasts'] as List ?? [])
          .cast<Map<String, dynamic>>()
          .map((d) => Podcast.fromJson(d))
          .toList(),
    );
  }

  final String id;
  final String title;
  final List<Podcast> podcasts;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Curation: { id: $id }';
}

// @DataClassName('Todo')
// class Todos extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get title => text().withLength(min: 6, max: 32)();
//   TextColumn get content => text().named('body')();
//   IntColumn get category => integer().nullable()();
// }

// @DataClassName('Tag')
// class Tags extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   @JsonKey('description_highlighted')
//   TextColumn get description => text()();
// }

// @UseMoor(tables: [Todos, Tags])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase()
//       : super(LazyDatabase(
//           () async {
//             final dbFolder = await getApplicationDocumentsDirectory();
//             final file = File(p.join(dbFolder.path, 'db.sqlite'));
//             return VmDatabase(file);
//           },
//         ));

//   @override
//   int get schemaVersion => 1;
// }

// // This needs to be a top-level method because it's run on a background isolate
// DatabaseConnection _backgroundConnection() {
//   // construct the database. You can also wrap the VmDatabase in a "LazyDatabase" if you need to run
//   // work before the database opens.

//   return;
// }

// void test() async {
//   // create a moor executor in a new background isolate. If you want to start the isolate yourself, you
//   // can also call MoorIsolate.inCurrent() from the background isolate

//   final moorIsolate = await MoorIsolate.spawn(
//     () => DatabaseConnection.fromExecutor(
//       LazyDatabase(
//         () async {
//           final dbFolder = await getApplicationDocumentsDirectory();
//           final file = File(p.join(dbFolder.path, 'db.sqlite'));
//           return VmDatabase(file);
//         },
//       ),
//     ),
//   );

//   // we can now create a database connection that will use the isolate internally. This is NOT what's
//   // returned from _backgroundConnection, moor uses an internal proxy class for isolate communication.
//   final connection = await moorIsolate.connect();

//   final db = TodoDb.connect(connection);

//   // you can now use your database exactly like you regularly would, it transparently uses a
//   // background isolate internally
// }
