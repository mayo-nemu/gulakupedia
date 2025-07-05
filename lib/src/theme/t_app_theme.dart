import 'package:flutter/material.dart';
import 't_app_color_scheme.dart';
import 't_text_theme.dart';
import 't_elevated_button_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    colorScheme: TAppColorScheme.lightColorScheme,
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: TTextTheme.lighTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lighElevatedButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    textTheme: TTextTheme.darkTextTheme,
  );
}
