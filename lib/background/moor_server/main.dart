import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';

class _IsolateStartRequest {
  final SendPort sendMoorIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendMoorIsolate, this.targetPath);
}

void _startIsolate(_IsolateStartRequest request) {
  final database = VmDatabase(File(request.targetPath), logStatements: true);
  final moorIsolate = MoorIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(database),
  );

  request.sendMoorIsolate.send(moorIsolate);
}

Future<MoorIsolate> _newMoorIsolate() async {
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDir.path, 'db.sqlite');
  final receivePort = ReceivePort();

  // await File(dbPath).delete();

  // Start Moor in a new isolate
  await Isolate.spawn(
    _startIsolate,
    _IsolateStartRequest(receivePort.sendPort, dbPath),
  );

  // Receive MoorIsolate as the first message
  final moorIsolate = (await receivePort.first as MoorIsolate);

  // Register MoorIsolates sendport
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
      : _newMoorIsolate();
}

Future<SqlDb> newSqlDb() async {
  final moorIsolate = await getMoorIsolate();
  final databaseConnection = await moorIsolate.connect();
  return SqlDb.connect(databaseConnection);
}
