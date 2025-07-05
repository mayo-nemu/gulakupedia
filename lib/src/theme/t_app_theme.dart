import 'package:flutter/material.dart';
import 'package:gulapedia/src/theme/t_navigation_bar.dart';
import 't_app_colors.dart';
import 't_app_text.dart';
import 't_elevated_button.dart';
import 't_date_picker.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    colorScheme: TAppColors.lightTheme,
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: TAppText.lightTheme,
    elevatedButtonTheme: TElevatedButton.lightTheme,
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    ),
    datePickerTheme: TDatePicker.lightTheme,
    navigationBarTheme: TNavigationBar.lightTheme,
  );
}
