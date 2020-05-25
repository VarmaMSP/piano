import 'package:flutter/material.dart';

/// mapRange maps value from range [x1, x2] to [y1, y2]
double mapRange(double x1, double x2, double y1, double y2, double value) {
  if (value <= x1) {
    return y1;
  }
  if (value >= x2) {
    return y2;
  }
  return y1 + ((y2 - y1) / (x2 - x1)) * (value - x1);
}

/// getScreenHeight returns height of safe area
double getScreenHeight(BuildContext context) {
  final padding = MediaQuery.of(context).padding;
  return MediaQuery.of(context).size.height - padding.top - padding.bottom;
}
