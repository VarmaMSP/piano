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

DateTime parseDateTime(String dateTimeStr) {
  return dateTimeStr != null
      ? DateTime.parse('$dateTimeStr +00:00')
      : DateTime.now();
}

// Fomats datetime to human readable date
String formatPubDate(DateTime dateTime) {
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

String getIdFromUrlParam(String urlParam) {
  return urlParam.split('-').last;
}

/// use this to silent pedantic linting rules
void unawaited(Future<void> future) {}

bool listExists<T>(List<T> list, T val) {
  return list.firstWhere((x) => x == val, orElse: () => null) != null;
}

List<T> listDelete<T>(List<T> list, T val) {
  final tmp = [...list];
  tmp.removeWhere((x) => x == val);
  return tmp;
}

List<T> listRemoveDuplicates<T>(List<T> list, String Function(T) getId) {
  var ids = <String, bool>{};
  var res = <T>[];
  for (var t in list) {
    final id = getId(t);
    if (ids[id] == null) {
      res.add(t);
    }
    ids[id] = true;
  }
  return res;
}

List<T> listDifference<T>(List<T> a, List<T> b, String Function(T) getId) {
  var ids = {for (var t in b) getId(t): true};
  var res = <T>[];
  for (var t in a) {
    if (ids[getId(t)] == null) {
      res.add(t);
    }
  }
  return res;
}
