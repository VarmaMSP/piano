part of 'alarm_service.dart';

// THIS CODE IS RUN IN SEPERATE ISOLATE
Store store;
AlarmService alarmService;

bool _isTaskRunnerActive = false;

void startTaskRunner(int x) async {
  store ??= newStore(await newApi(), await newDb());
  alarmService ??= await newAlarmService();

  if (!_isTaskRunnerActive) {
    _isTaskRunnerActive = true;

    try {
      await TaskRunner(
        store: store,
        alarmService: alarmService,
        mode: TaskRunnerMode.values[x],
      ).start();
    } finally {
      _isTaskRunnerActive = false;
    }
  }
}
