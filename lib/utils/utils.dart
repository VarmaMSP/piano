// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart' as intl;
import 'package:timeago/timeago.dart' as timeago;

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

// Format datetime to human readable date
String formatPubDate(DateTime dateTime) {
  return intl.DateFormat('MMM d, yyyy').format(dateTime);
}

// Format datetime to time from now
String formatRelativeTime(DateTime dateTime) {
  return timeago.format(dateTime).replaceAll(RegExp('about '), '');
}

/// GetScreenHeight returns height of safe area
/// If buildContext is not provided cached value is returned
final getScreenHeight = () {
  double screenHeight;
  double topPadding;
  double bottomPadding;
  return ({BuildContext context, bool ignorePadding = false}) {
    if (screenHeight == null) {
      assert(context != null);
    }

    if (context != null || screenHeight == null) {
      final padding = MediaQuery.of(context).padding;
      final height = MediaQuery.of(context).size.height;
      screenHeight = height;
      topPadding = padding.top;
      bottomPadding = padding.bottom;
    }

    return ignorePadding
        ? screenHeight
        : screenHeight - topPadding - bottomPadding;
  };
}();

/// GetScreenWidth returns height of safe area
/// If buildContext is not provided cached value is returned
final getScreenWidth = () {
  double screenWidth;
  double leftPadding;
  double rightPadding;
  return ({BuildContext context, bool ignorePadding = false}) {
    if (screenWidth == null) {
      assert(context != null);
    }

    if (context != null || screenWidth == null) {
      final padding = MediaQuery.of(context).padding;
      final width = MediaQuery.of(context).size.width;
      screenWidth = width;
      leftPadding = padding.left;
      rightPadding = padding.right;
    }

    return ignorePadding
        ? screenWidth
        : screenWidth - leftPadding - rightPadding;
  };
}();

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
