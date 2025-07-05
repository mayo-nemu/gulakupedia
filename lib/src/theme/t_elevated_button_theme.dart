import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static const ElevatedButtonThemeData lighElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll<double>(0),
          backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF1A998E)),
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
          shape: WidgetStatePropertyAll<OutlinedBorder>(StadiumBorder()),
        ),
      );
}
