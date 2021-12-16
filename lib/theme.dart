import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: const Color(0xff003673),
    textTheme: GoogleFonts.latoTextTheme(
      Theme.of(context).textTheme,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.blue.shade900),
      border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
    ),
  );
}