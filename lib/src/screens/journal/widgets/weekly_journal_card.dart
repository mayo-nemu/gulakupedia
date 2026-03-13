import 'package:flutter/material.dart';
import 'package:gulapedia/src/utilities/double_to_string.dart';

import 'package:gulapedia/src/screens/journal/models/weekly_journal.dart';

class WeeklyJournalCard extends StatelessWidget {
  const WeeklyJournalCard({
    super.key,
    required this.weekNumber,
    required this.journals,
    required this.recSugars,
    required this.recCalories,
    required this.macro,
  });

  final int weekNumber;
  final WeeklyJournals journals;
  final double recSugars;
  final double recCalories;
  final Map<String, double> macro;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'Minggu: $weekNumber',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNutritionItem(
                    context,
                    label: 'Gula',
                    unit: 'g',
                    value: journals.totalSugars,
                    maxValue: recSugars * 7,
                  ),
                  _buildNutritionItem(
                    context,
                    label: 'Kalori',
                    unit: 'kcal',
                    value: journals.totalCalories,
                    maxValue: recCalories * 7,
                  ),
                  _buildNutritionItem(
                    context,
                    label: 'Protein',
                    unit: 'g',
                    value: journals.totalProtein,
                    maxValue: macro['protein']! * 7,
                  ),
                  _buildNutritionItem(
                    context,
                    label: 'Lemak',
                    unit: 'g',
                    value: journals.totalFat,
                    maxValue: macro['fat']! * 7,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildNutritionItem(
  BuildContext context, {
  required String label,
  required String unit,
  required double value,
  required double maxValue,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${doubleToString(value)} / ${doubleToString(maxValue)} $unit',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 1),
        ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: SizedBox(
            height: 6, 
            child: Stack(
              children: [
                LinearProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  minHeight: 6,
                  value: (maxValue > 0)
                      ? (value / maxValue).clamp(0.0, 1.0)
                      : 0,
                ),
                // 70% Marker
                Align(
                  alignment: const Alignment(-1.0 + (0.7 * 2), 0),
                  child: Container(
                    width: 5,
                    color: Colors.orange,
                  ),
                ),
                // 90% Marker
                Align(
                  alignment: const Alignment(-1.0 + (0.9 * 2), 0),
                  child: Container(
                    width: 5,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
