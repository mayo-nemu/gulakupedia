import 'package:flutter/material.dart';

class FoodList extends StatelessWidget {
  final List<FoodItem> foods;

  const FoodList({required this.foods, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final item = foods[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.foodName,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '(${item.foodWeightGrams} gram)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Grade: ${item.sugarsGrade}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: Colors.green),
                ),
              ],
            ),
            Text(
              '${item.sugarsGrams} g',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}

class FoodItem {
  final String foodName;
  final double sugarsGrams;
  final String sugarsGrade;
  final double foodWeightGrams;
  FoodItem({
    required this.foodName,
    required this.sugarsGrams,
    required this.sugarsGrade,
    required this.foodWeightGrams,
  });
}
