import 'package:flutter/material.dart';

class TNavigationBar {
  static final lightTheme = NavigationBarThemeData(
    backgroundColor: Color(0xFFFFFFFF),
    indicatorColor: Colors.transparent,
    labelTextStyle: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A998E),
        );
      }
      return TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF000000),
      );
    }),
  );
}
