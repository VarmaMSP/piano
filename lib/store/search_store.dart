// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/alarm_service/alarm_service.dart';
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/db/db.dart';

SearchStore newSearchStore(Api api, Db db, [AlarmService alarmService]) {
  return _SearchStoreImpl(api: api, db: db, alarmService: alarmService);
}

abstract class SearchStore {
  Future<List<SearchSuggestion>> getSuggestions(String searchText);
}

class _SearchStoreImpl extends SearchStore {
  final Db db;
  final Api api;
  final AlarmService alarmService;

  _SearchStoreImpl({
    @required this.db,
    @required this.api,
    @required this.alarmService,
  });

  @override
  Future<List<SearchSuggestion>> getSuggestions(String searchText) {
    return api.search.getSuggestions(searchText);
  }
}
