import 'package:flutter/material.dart';

ThemeData customTheme = ThemeData(
  fontFamily: "SF Pro",
  appBarTheme: const AppBarTheme(color: Colors.black, centerTitle: true),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    extendedTextStyle: TextStyle(fontWeight: FontWeight.w600),
  ),
);
