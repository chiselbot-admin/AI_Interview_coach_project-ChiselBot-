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
        surfaceContainerHighest: Colors.grey.withAlpha(100),
        surfaceContainerLow: Colors.grey.withAlpha(50),
      ),
      scaffoldBackgroundColor: Colors.black,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.white),
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
      dialogTheme: DialogThemeData(backgroundColor: Colors.grey[900]));

  //=============================================================================
  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.withAlpha(50),
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
        surfaceContainerHighest: Colors.blueAccent.withAlpha(50),
        surfaceContainerLow: Colors.grey.withAlpha(50),
      ),
      scaffoldBackgroundColor: Colors.white,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.black),
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
      dialogTheme: DialogThemeData(backgroundColor: Colors.white));
}
