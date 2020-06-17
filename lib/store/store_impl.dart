import 'package:phenopod/background/moor_server/main.dart';
import 'package:phenopod/services/sqldb/sqldb.dart';
import 'package:phenopod/store/api_store/api_store.dart';
import 'package:phenopod/store/db_layer/db_layer.dart';
import 'package:phenopod/store/store.dart';

Future<Store> newStore() async {
  final moorIsolate = await getMoorIsolate();
  final databaseConnection = await moorIsolate.connect();
  final sqlDb = SqlDb.connect(databaseConnection);

  return DbLayer(baseStore: ApiStore(), sqlDb: sqlDb);
}
