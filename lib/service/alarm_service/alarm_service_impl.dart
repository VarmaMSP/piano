part of 'alarm_service.dart';

class _AlarmServiceImpl extends AlarmService {
  static const int taskRunnerId = 0;

  @override
  Future<bool> scheduleTaskRunner() {
    return AndroidAlarmManager.oneShot(
      Duration.zero,
      taskRunnerId,
      startTaskRunner,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }
}
