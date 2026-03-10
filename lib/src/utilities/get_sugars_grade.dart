import 'package:flutter/material.dart';
import 'package:gulapedia/src/theme/t_app_text.dart';

Widget getSugarGrade(double sugarAmount) {
  if (sugarAmount < 0) {
    return const Text('Invalid Input');
  }

  late String grade;
  late Color bgColor;

  if (sugarAmount <= 5.0) {
    grade = 'GRADE: A';
    bgColor = const Color(0xFF28C76F);
  } else if (sugarAmount <= 10.0) {
    grade = 'GRADE: B';
    bgColor = const Color(0xFFA3CB38);
  } else if (sugarAmount <= 15.0) {
    grade = 'GRADE: C';
    bgColor = const Color(0xFFFFA500);
  } else {
    grade = 'GRADE: D';
    bgColor = const Color(0xFFFF4C4C);
  }

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          grade,
          style: TAppText.lightTheme.bodySmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 10,
            letterSpacing: 0.5,
          ),
        ),
      ),
    ],
  );
}
