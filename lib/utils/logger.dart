import 'package:logger/logger.dart';

Logger newLogger(String className) {
  return Logger(
    printer: AppLogPrinter(className),
    level: Level.debug,
  );
}

class AppLogPrinter extends LogPrinter {
  final String className;

  AppLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    var emoji = PrettyPrinter.levelEmojis[event.level];
    return ['$emoji$emoji$emoji$emoji $className - ${event.message}'];
  }
}
