import 'package:flutter/material.dart';

class TElevatedButton {
  static const lightTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(Color(0xFF1A998E)),
      foregroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
      shape: WidgetStatePropertyAll(StadiumBorder()),
    ),
  );
}
