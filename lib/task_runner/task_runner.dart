import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

class TaskRunner {
  final Api api;
  final Db db;

  TaskRunner({@required this.api, @required this.db});
}
