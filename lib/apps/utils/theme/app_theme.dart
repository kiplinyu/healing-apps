import 'package:flutter/material.dart';

class AppTheme {
  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'SFUI',
      fontWeight: FontWeight.w300,
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'SFUI',
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    labelLarge: TextStyle(
      fontFamily: 'SFUI',
      fontWeight: FontWeight.w600,
      fontSize: 26,
    ),
    // Tambahkan style lain sesuai kebutuhan
  );

  static ThemeData lightTheme = ThemeData(
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    // Konfigurasi tema lain
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    textTheme: textTheme,
    // Konfigurasi tema dark mode
  );
}
