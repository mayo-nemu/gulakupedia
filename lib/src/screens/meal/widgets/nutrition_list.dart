part of 'package:gulapedia/src/screens/meal/views/meal_screen.dart';

class NutritionList extends StatelessWidget {
  const NutritionList({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kandungan Nutrisi',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 21),
        NutritionItem(
          nutritionName: 'Kalori',
          nutritionTotal: meal.totalCaloriesGram,
          nutritionUnit: 'kcal',
        ),
        SizedBox(height: 21),
        NutritionItem(
          nutritionName: 'Protein',
          nutritionTotal: meal.totalProteinGram,
          nutritionUnit: 'g',
        ),
        SizedBox(height: 21),
        NutritionItem(
          nutritionName: 'Lemak',
          nutritionTotal: meal.totalFatGram,
          nutritionUnit: 'g',
        ),
        SizedBox(height: 21),

        NutritionItem(
          nutritionName: 'Gula',
          nutritionTotal: meal.totalSugarsGram,
          nutritionUnit: 'g',
        ),
      ],
    );
  }
}

class NutritionItem extends StatelessWidget {
  const NutritionItem({
    super.key,
    required this.nutritionName,
    required this.nutritionUnit,
    this.nutritionTotal,
  });

  final String nutritionName;
  final String nutritionUnit;
  final double? nutritionTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(nutritionName, style: Theme.of(context).textTheme.headlineSmall),
        Text(
          nutritionTotal != null
              ? '${nutritionTotal!.toStringAsFixed(2)} $nutritionUnit'
              : 'No data',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
