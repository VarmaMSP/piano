// Package imports:
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:phenopod/task_runner/task_runner.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/store/store.dart';

part 'tasks.dart';

Future<AlarmService> newAlarmService() async {
  await AndroidAlarmManager.initialize();
  return _AlarmServiceImpl();
}

/// AlarmService is used to schedule background services
/// and is backed by android alarm manager
abstract class AlarmService {
  Future<bool> scheduleTaskRunner({
    TaskRunnerMode mode = TaskRunnerMode.foreground,
  });
}

class _AlarmServiceImpl extends AlarmService {
  @override
  // ignore: missing_return
  Future<bool> scheduleTaskRunner({
    TaskRunnerMode mode = TaskRunnerMode.foreground,
  }) {
    switch (mode) {
      case TaskRunnerMode.foreground:
        return AndroidAlarmManager.oneShot(
          const Duration(seconds: 0),
          TaskRunnerMode.foreground.index,
          startTaskRunner,
          exact: true,
          wakeup: true,
        );

      case TaskRunnerMode.background:
        return AndroidAlarmManager.oneShot(
          const Duration(minutes: 5),
          TaskRunnerMode.background.index,
          startTaskRunner,
          exact: true,
          wakeup: true,
        );
    }
  }
}
