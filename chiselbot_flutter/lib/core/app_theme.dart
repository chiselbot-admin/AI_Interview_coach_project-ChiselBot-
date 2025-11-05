import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: Colors.white)),
    iconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.grey.shade800,
    dialogBackgroundColor: Colors.black,
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.poppins(color: Colors.white),
    ).apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            disabledForegroundColor: Colors.red)),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
    ),
  );

  //=============================================================================
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: Colors.black)),
    iconTheme: const IconThemeData(color: Colors.black),
    dividerColor: Colors.grey.shade300,
    dialogBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.poppins(color: Colors.black),
    ).apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.grey)),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    ),
  );
}
