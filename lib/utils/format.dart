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
