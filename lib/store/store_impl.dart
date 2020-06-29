import 'package:phenopod/service/http_client.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/api_store/api_store.dart';
import 'package:phenopod/store/db_layer/db_layer.dart';
import 'package:phenopod/store/store.dart';

Store newStore(SqlDb sqlDb, HttpClient httpClient) {
  return DbLayer(
    baseStore: ApiStore(httpClient),
    sqlDb: sqlDb,
  );
}
