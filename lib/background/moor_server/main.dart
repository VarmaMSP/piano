import 'dart:io';
import 'dart:ui';

import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

DatabaseConnection _backgroundConnection() {
  final database = LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'db.sqlite'));
      return VmDatabase(file);
    },
  );

  return DatabaseConnection.fromExecutor(database);
}

Future<MoorIsolate> _newIsolate() async {
  final moorIsolate = await MoorIsolate.spawn(_backgroundConnection);
  IsolateNameServer.registerPortWithName(
    moorIsolate.connectPort,
    'MOOR_ISOLATE',
  );

  return moorIsolate;
}

Future<MoorIsolate> getMoorIsolate() {
  final sendPort = IsolateNameServer.lookupPortByName('MOOR_ISOLATE');
  return sendPort != null
      ? Future.value(MoorIsolate.fromConnectPort(sendPort))
      : _newIsolate();
}
