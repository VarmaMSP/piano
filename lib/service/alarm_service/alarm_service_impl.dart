part of 'alarm_service.dart';

class _AlarmServiceImpl extends AlarmService {
  static const int taskRunnerPeriodicAlarmId = 0;

  @override
  Future<bool> scheduleTaskRunnerOnce() {
    return AndroidAlarmManager.oneShot(
      const Duration(seconds: 1),
      Random().nextInt(pow(2, 31)),
      startTaskRunner,
      exact: true,
      wakeup: true,
    );
  }

  @override
  Future<bool> scheduleTaskRunnerPeriodic() {
    return AndroidAlarmManager.periodic(
      Duration(minutes: 1),
      taskRunnerPeriodicAlarmId,
      startTaskRunner,
      exact: false,
      rescheduleOnReboot: true,
    );
  }
}
