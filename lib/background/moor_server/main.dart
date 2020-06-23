import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuple/tuple.dart';

// Startt moorIsolate and sendback the result
void _moor(Tuple2<SendPort, String> request) {
  final database = VmDatabase(File(request.item2), logStatements: false);
  final moorIsolate = MoorIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(database),
  );
  request.item1.send(moorIsolate);
}

Future<MoorIsolate> _startIsolate() async {
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDir.path, 'db.sqlite');
  final receivePort = ReceivePort();

  // Start Moor in a new isolate
  await Isolate.spawn(_moor, Tuple2(receivePort.sendPort, dbPath));

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
      : _startIsolate();
}
