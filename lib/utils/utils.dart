import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';

// Format given duration to 00:00 format
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

// Fomats datetime to human readable date
String formatDateTime(String dateTimeStr) {
  final dateTime = DateTime.parse('$dateTimeStr +00:00');
  return intl.DateFormat('MMM d, yyyy').format(dateTime);
}

// Format datetime to time from now
String formatRelativeTime(String dateTimeStr) {
  final dateTime = DateTime.parse('$dateTimeStr +00:00');
  return timeago.format(dateTime);
}

/// getScreenHeight returns height of safe area
double getScreenHeight(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  return MediaQuery.of(context).size.height - padding.top - padding.bottom;
}

/// getScreenWidth returns width of screen
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// mapRange maps a value from range [x1, x2] to [y1, y2]
double mapRange(double x1, double x2, double y1, double y2, double value) {
  if (value <= x1) {
    return y1;
  }
  if (value >= x2) {
    return y2;
  }
  return y1 + ((y2 - y1) / (x2 - x1)) * (value - x1);
}

void unawaited(Future<void> future) {}
