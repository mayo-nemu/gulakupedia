import 'package:flutter/material.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Kandungan Nutrisi'),
            _buildNutritionItem(nutritionName: 'Kalori', nutritionUnit: 'kcal'),
            _buildNutritionItem(nutritionName: 'Protein', nutritionUnit: 'g'),
            _buildNutritionItem(nutritionName: 'Lemak', nutritionUnit: 'g'),
            _buildNutritionItem(nutritionName: 'Gula', nutritionUnit: 'g'),
          ],
        ),
      ),
    );
  }
}

Widget _buildNutritionItem({
  required String nutritionName,
  required String nutritionUnit,
  double? nutritionTotal,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(nutritionName),
      Text(
        nutritionTotal != null
            ? '${nutritionTotal.toStringAsFixed(2)} $nutritionUnit'
            : 'No data',
      ),
    ],
  );
}
