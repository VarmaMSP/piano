import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:phenopod/background/task_runner/task_runner.dart';

part 'alarm_service_impl.dart';

Future<AlarmService> newAlarmService() async {
  await AndroidAlarmManager.initialize();
  return _AlarmServiceImpl();
}

/// AlarmService is used to schedule various background services
/// and is backed by android alarm manager
abstract class AlarmService {
  /// Schedule Task runner
  Future<void> scheduleTaskRunner();
}
