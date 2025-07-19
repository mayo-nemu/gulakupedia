import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:gulapedia/src/utilities/double_to_string.dart';
import 'package:gulapedia/src/utilities/get_sugars_grade.dart';
import 'package:journal_repository/journal_repository.dart';

class FoodList extends StatelessWidget {
  final List<Food> foods;

  const FoodList({required this.foods, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final item = foods[index];
        return _buildFoodItem(context, food: item);
      },
    );
  }

  Widget _buildFoodItem(BuildContext context, {required Food food}) {
    final double sugarsTotal = (food.sugars100g / 100) * food.servingSizeGram;

    return ListTile(
      title: Text(food.name, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: getSugarGrade(sugarsTotal),
      trailing: Text(
        '${doubleToString(sugarsTotal)} g',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: () => context.pushNamed(RoutesName.makanan, extra: food),
    );
  }
}
