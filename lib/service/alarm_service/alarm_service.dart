// Dart imports:
import 'dart:math';

// Package imports:
import 'package:android_alarm_manager/android_alarm_manager.dart';

// Project imports:
import 'package:phenopod/background/task_runner/task_runner.dart';

part 'alarm_service_impl.dart';

Future<AlarmService> newAlarmService() async {
  await AndroidAlarmManager.initialize();
  return _AlarmServiceImpl();
}

/// AlarmService is used to schedule various background services
/// and is backed by android alarm manager
abstract class AlarmService {
  /// Schedule Task runner to exactly once without any delay from now
  Future<bool> scheduleTaskRunnerOnce();

  /// Schedule Task runner periodically
  Future<bool> scheduleTaskRunnerPeriodic();
}
