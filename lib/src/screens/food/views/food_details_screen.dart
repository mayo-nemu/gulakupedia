import 'package:flutter/material.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:journal_repository/journal_repository.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({super.key, required this.food});
  final Food food;
  @override
  Widget build(BuildContext context) {
    return LayoutAppbar(
      title: 'Keterangan',
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Center(
              child: Text(
                food.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          _buildNutritionDetail(context, food),
        ],
      ),
    );
  }

  _buildNutritionItem(
    BuildContext context, {
    required String label,
    required double value,
    required String unit,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.headlineSmall),
        Text(
          '${value.toStringAsFixed(2)} $unit',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }

  _buildNutritionDetail(BuildContext context, Food food) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kandungan Nutrisi',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 28),
          _buildNutritionItem(
            context,
            label: 'Kalori',
            value: food.calories100g,
            unit: 'kcal',
          ),
          SizedBox(height: 20),
          _buildNutritionItem(
            context,
            label: 'Protein',
            value: food.protein100g,
            unit: 'g',
          ),
          SizedBox(height: 20),
          _buildNutritionItem(
            context,
            label: 'Lemak',
            value: food.fat100g,
            unit: 'g',
          ),
          SizedBox(height: 20),
          _buildNutritionItem(
            context,
            label: 'Gula',
            value: food.sugars100g,
            unit: 'g',
          ),
        ],
      ),
    );
  }
}
