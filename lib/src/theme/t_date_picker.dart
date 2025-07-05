import 'package:flutter/material.dart';
import 'package:gulapedia/src/theme/t_app_text.dart';

class TDatePicker {
  static final lightTheme = DatePickerThemeData(
    backgroundColor: Color(0xFFFFFFFF),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    headerBackgroundColor: Color(0xFF1A998E),
    headerForegroundColor: Color(0xFFFFFFFF),
    surfaceTintColor: Colors.transparent,
    dividerColor: Colors.transparent,
    weekdayStyle: TAppText.lightTheme.bodyLarge,
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF1A998E);
      }
      return Colors.transparent;
    }),
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFFFFFFFF);
      }
      return Colors.black;
    }),
    todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF1A998E);
      }
      return Color(0x181A998E);
    }),
    todayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFFFFFFFF);
      }
      return Color(0xFF1A998E);
    }),
    yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF1A998E);
      }
      return Colors.transparent;
    }),
    yearForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFFFFFFFF);
      }
      return Color(0xFF000000);
    }),
  );
}
