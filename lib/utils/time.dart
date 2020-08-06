String formatDurationToWords(Duration duration) {
  final totalSeconds = duration.inSeconds;
  final hours = duration.inHours;
  final minutes = duration.inMinutes - 60 * hours;

  if (totalSeconds < 60) {
    return '1 m';
  }
  if (totalSeconds < 60 * 60) {
    return '${minutes} m';
  }
  return '${hours}h ${minutes}m';
}
