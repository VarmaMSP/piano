String formatDurationToWords(Duration duration) {
  final totalSeconds = duration.inSeconds;
  final hours = duration.inHours;
  final minutes = duration.inMinutes - 60 * hours;

  if (totalSeconds < 60) {
    return '1 min';
  }
  if (totalSeconds < 60 * 60) {
    return '${minutes} min';
  }
  return '${hours} hr ${minutes} min';
}
