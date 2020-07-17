part of 'alarm_service.dart';

class _AlarmServiceImpl extends AlarmService {
  static const int taskRunnerOneShotAlarmId = 1;
  static const int taskRunnerPeriodicAlarmId = 0;

  @override
  Future<bool> scheduleTaskRunnerOnce() {
    return AndroidAlarmManager.oneShot(
      Duration.zero,
      taskRunnerOneShotAlarmId,
      startTaskRunner,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  @override
  Future<bool> scheduleTaskRunnerPeriodic() {
    return AndroidAlarmManager.periodic(
      Duration(minutes: 5),
      taskRunnerPeriodicAlarmId,
      startTaskRunner,
      exact: false,
      rescheduleOnReboot: true,
    );
  }
}
