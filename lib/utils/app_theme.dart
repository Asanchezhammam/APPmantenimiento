import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    scaffoldBackgroundColor: const Color(0xffCAD2F5),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
  );
}
