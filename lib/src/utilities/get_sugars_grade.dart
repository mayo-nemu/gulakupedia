import 'package:flutter/material.dart';
import 'package:gulapedia/src/theme/t_app_text.dart';

Text getSugarGrade(double sugarAmount) {
  if (sugarAmount < 0) {
    return Text('Invalid Input: Sugar amount cannot be negative.');
  }

  if (sugarAmount <= 5.0) {
    return Text(
      'Grade: A',
      style: TAppText.lightTheme.bodySmall!.copyWith(color: Colors.tealAccent),
    );
  } else if (sugarAmount <= 10.0) {
    return Text(
      'Grade: B',
      style: TAppText.lightTheme.bodySmall!.copyWith(
        color: Colors.lightGreenAccent,
      ),
    );
  } else if (sugarAmount <= 15.0) {
    return Text(
      'Grade C',
      style: TAppText.lightTheme.bodySmall!.copyWith(color: Colors.yellow[700]),
    );
  } else {
    return Text(
      'Grade: D',
      style: TAppText.lightTheme.bodySmall!.copyWith(color: Colors.red),
    );
  }
}
