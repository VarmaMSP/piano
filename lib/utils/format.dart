import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart' as intl;

String formatDuration({
  int minutes = 0,
  int seconds = 0,
  int milliSeconds = 0,
}) {
  final secs = minutes * 60 + seconds + (milliSeconds / 1000).floor();

  RegExp regex;
  if (secs < 60 * 60) {
    regex = RegExp(r'\d\d:(\d\d:\d\d)');
  } else if (secs < 10 * 60 * 60) {
    regex = RegExp(r'\d(\d:\d\d:\d\d)');
  } else {
    regex = RegExp(r'(\d\d:\d\d:\d\d)');
  }

  return regex
          .firstMatch(DateTime(0, 0, 0, 0, 0, secs).toIso8601String())
          ?.group(1) ??
      '00:00';
}

String formatDateTime(String dateTimeStr) {
  final dateTime = DateTime.parse('$dateTimeStr +00:00');
  return intl.DateFormat('MMM d, yyyy').format(dateTime);
}

String formatRelativeTime(String dateTimeStr) {
  final dateTime = DateTime.parse('$dateTimeStr +00:00');
  return timeago.format(dateTime);
}
