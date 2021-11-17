import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildThemeData(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.green,
    textTheme: GoogleFonts.latoTextTheme(
      Theme.of(context).textTheme,
    )
  );
}