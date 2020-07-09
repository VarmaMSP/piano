import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
    },
  ),
  textTheme: TextTheme(
    headline5: GoogleFonts.inter(
      fontSize: 16,
      color: Colors.black,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
    ),
    headline6: GoogleFonts.inter(
      fontSize: 14,
      color: Colors.black,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: GoogleFonts.roboto(
      fontSize: 13,
      color: Colors.grey.shade900,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w400,
    ),
    subtitle2: GoogleFonts.roboto(
      fontSize: 12,
      color: Colors.grey.shade600,
      height: 1.35,
      letterSpacing: 0.25,
    ),
  ),
);
