import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: const Color(0xff29abe2),
      textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.blue.shade900),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(const Color(0xff0071bc))),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          )),
          foregroundColor: MaterialStateProperty.all(const Color(0xff0071bc)),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(24),
          ),
        ),
      ));
}
