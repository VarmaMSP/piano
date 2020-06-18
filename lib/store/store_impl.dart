import 'package:path_provider/path_provider.dart';
import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/api_store/api_store.dart';
import 'package:phenopod/store/db_layer/db_layer.dart';
import 'package:phenopod/store/store.dart';

Future<Store> newStore(SqlDb sqlDb) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final apiStore = ApiStore(HttpClient(appDocDir: appDocDir.path));

  return DbLayer(baseStore: apiStore, sqlDb: sqlDb);
}
