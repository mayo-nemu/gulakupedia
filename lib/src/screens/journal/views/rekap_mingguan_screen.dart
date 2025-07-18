import 'package:flutter/material.dart';
import 'package:journal_repository/journal_repository.dart';

class RekapMingguanScreen extends StatelessWidget {
  const RekapMingguanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget _buildNutritionItem(
    BuildContext context, {
    required String label,
    required double value,
  }) {
    return Column(
      children: [
        Row(children: [Text(label)]),
        LinearProgressIndicator(),
      ],
    );
  }

  Widget _buildWeekCard(BuildContext context, {required List<Meal> meals}) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Column(children: []),
    );
  }
}
