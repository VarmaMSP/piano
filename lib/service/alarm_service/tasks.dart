part of 'alarm_service.dart';

// THIS CODE IS RUN IN SEPERATE ISOLATE
Db db;
Api api;
AlarmService alarmService;

bool _isTaskRunnerActive = false;

void startTaskRunner(int x) async {
  db ??= await newDb();
  api ??= await newApi();
  alarmService ??= await newAlarmService();

  if (!_isTaskRunnerActive) {
    _isTaskRunnerActive = true;

    try {
      await TaskRunner(
        db: db,
        api: api,
        alarmService: alarmService,
        mode: TaskRunnerMode.values[x],
      ).start();
    } finally {
      _isTaskRunnerActive = false;
    }
  }
}
