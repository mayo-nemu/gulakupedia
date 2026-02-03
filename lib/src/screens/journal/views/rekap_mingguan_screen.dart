// rekap_mingguan_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulapedia/src/utilities/daily_recommended_intake.dart';
import 'package:gulapedia/src/utilities/double_to_string.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:user_repository/user_repository.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:collection/collection.dart'; // For groupBy

import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/screens/journal/blocs/journal_bloc/journal_bloc.dart'; // Import JournalBloc

/// A simple class to hold aggregated weekly data for display.
class WeeklySummary {
  final DateTime startOfWeek;
  final DateTime endOfWeek;
  final List<Journal> journalsInWeek;
  final List<Meal> mealsInWeek;
  final double totalSugars;
  final double totalProtein;
  final double totalFat;
  final double totalCalories;

  WeeklySummary({
    required this.startOfWeek,
    required this.endOfWeek,
    required this.journalsInWeek,
    required this.mealsInWeek,
    required this.totalSugars,
    required this.totalProtein,
    required this.totalFat,
    required this.totalCalories,
  });
}

/// ViewModel to process raw monthly journal and meal data into weekly summaries.
class WeeklySummaryViewModel {
  final List<Journal> monthlyJournals;
  final List<Meal> monthlyMeals;

  WeeklySummaryViewModel({
    required this.monthlyJournals,
    required this.monthlyMeals,
  });

  /// Helper to get the start of the week (Monday) for a given date.
  DateTime _getStartOfWeek(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(Duration(days: date.weekday - 1));
  }

  /// Helper to get the end of the week (Sunday) for a given week start date.
  DateTime _getEndOfWeek(DateTime startOfWeek) {
    return startOfWeek.add(const Duration(days: 6));
  }

  /// Helper to get the ISO week number for a given date.
  int _getWeekNumber(DateTime date) {
    // Find the nearest Thursday to the given date.
    // ISO week number is based on the week containing Thursday.
    DateTime thursday = date.add(
      Duration(days: DateTime.thursday - date.weekday),
    );

    // Handle the case where the date is in the last days of December
    // but belongs to the first week of the next year.
    // Or if it's in the first days of January but belongs to the last week
    // of the previous year.
    DateTime firstDayOfYear = DateTime(thursday.year, 1, 1);
    DateTime firstThursdayOfYear = firstDayOfYear.add(
      Duration(
        days:
            DateTime.thursday -
            firstDayOfYear.weekday +
            (firstDayOfYear.weekday > DateTime.thursday ? 7 : 0),
      ),
    );

    // Calculate the difference in days from the first Thursday of the year
    // and divide by 7 to get the week number.
    return 1 + (thursday.difference(firstThursdayOfYear).inDays ~/ 7);
  }

  /// Groups journals by the start of their respective weeks.
  Map<DateTime, List<Journal>> _groupJournalsByWeek() {
    return groupBy(monthlyJournals, (journal) => _getStartOfWeek(journal.date));
  }

  /// Groups meals by the start of their respective weeks, using the journal's date.
  Map<DateTime, List<Meal>> _groupMealsByWeek(
    Map<DateTime, List<Journal>> journalsGroupedByWeek,
  ) {
    final Map<String, DateTime> journalIdToDate = {
      for (var journal in monthlyJournals) journal.id: journal.date,
    };

    return groupBy(monthlyMeals, (meal) {
      final journalDate = journalIdToDate[meal.journalId];
      return journalDate != null ? _getStartOfWeek(journalDate) : DateTime(0);
    });
  }

  /// Generates a list of [WeeklySummary] objects from the monthly data.
  List<WeeklySummary> getWeeklySummaries() {
    final List<WeeklySummary> summaries = [];

    final journalsGroupedByWeek = _groupJournalsByWeek();
    final mealsGroupedByWeek = _groupMealsByWeek(journalsGroupedByWeek);

    Set<DateTime> allWeekStarts = {};
    allWeekStarts.addAll(journalsGroupedByWeek.keys);
    allWeekStarts.addAll(mealsGroupedByWeek.keys);

    List<DateTime> sortedWeekStarts = allWeekStarts.toList()
      ..sort((a, b) => a.compareTo(b));

    for (var startOfWeek in sortedWeekStarts) {
      final endOfWeek = _getEndOfWeek(startOfWeek);
      final journalsInWeek = journalsGroupedByWeek[startOfWeek] ?? [];
      final mealsInWeek = mealsGroupedByWeek[startOfWeek] ?? [];

      double totalSugars = mealsInWeek.fold(
        0.0,
        (sum, meal) => sum + meal.totalSugarsGram,
      );
      double totalProtein = mealsInWeek.fold(
        0.0,
        (sum, meal) => sum + meal.totalProteinGram,
      );
      double totalFat = mealsInWeek.fold(
        0.0,
        (sum, meal) => sum + meal.totalFatGram,
      );
      double totalCalories = mealsInWeek.fold(
        0.0,
        (sum, meal) => sum + meal.totalCaloriesGram,
      );

      summaries.add(
        WeeklySummary(
          startOfWeek: startOfWeek,
          endOfWeek: endOfWeek,
          journalsInWeek: journalsInWeek,
          mealsInWeek: mealsInWeek,
          totalSugars: totalSugars,
          totalProtein: totalProtein,
          totalFat: totalFat,
          totalCalories: totalCalories,
        ),
      );
    }

    return summaries;
  }
}

class RekapMingguanScreen extends StatefulWidget {
  const RekapMingguanScreen({super.key, this.date});
  final DateTime? date; // Optional date to focus the report on

  @override
  State<RekapMingguanScreen> createState() => _RekapMingguanScreenState();
}

class _RekapMingguanScreenState extends State<RekapMingguanScreen> {
  late String _userId;
  late JournalBloc _journalBloc;

  @override
  void initState() {
    super.initState();
    _userId = context.read<AuthenticationBloc>().state.user!.userId;

    _journalBloc = context.read<JournalBloc>();

    _journalBloc.add(
      GetThisMonthJournals(_userId, widget.date ?? DateTime.now()),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildNutritionItem(
    BuildContext context, {
    required String label,
    required String unit,
    required double value,
    required double maxValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
              Text(
                '${doubleToString(value)} / ${doubleToString(maxValue)} $unit',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            value: (maxValue > 0) ? value / maxValue : 0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access recommended daily intake calculations based on the authenticated user.
    final MyUser user = context.read<AuthenticationBloc>().state.user!;
    final userData = DailyRecommendedIntake(
      dateOfBirth: user.birthday,
      gender: user.gender,
      weight: user.weight,
      height: user.height,
    );
    final tdee = userData.calculateTDEE(user.activities);
    final recCalories = userData.calculateRecommendedCalories(tdee, 'maintain');
    final macro = userData.calculateMacronutrients(recCalories);
    final recSugars = userData.calculateAddedSugarsLimit(recCalories);

    return LayoutAppbar(
      title: 'Rekap Mingguan',
      child: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          if (state.status == JournalStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == JournalStatus.failure) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage ?? "An unknown error occurred."}',
              ),
            );
          } else if (state.status == JournalStatus.loaded) {
            final viewModel = WeeklySummaryViewModel(
              monthlyJournals: state.periodJournals,
              monthlyMeals: state.allPeriodMeals,
            );
            final weeklySummaries = viewModel.getWeeklySummaries();

            if (weeklySummaries.isEmpty) {
              return const Center(
                child: Text('No weekly data available for this month.'),
              );
            }

            return ListView.builder(
              itemCount: weeklySummaries.length,
              itemBuilder: (context, index) {
                final summary = weeklySummaries[index];
                final weekNumber = viewModel._getWeekNumber(
                  summary.startOfWeek,
                );
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Minggu: $weekNumber',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Card(
                        color: Theme.of(context).colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildNutritionItem(
                                context,
                                label: 'Kalori',
                                unit: 'kcal',
                                value: summary.totalCalories,
                                maxValue: recCalories * 7,
                              ),
                              _buildNutritionItem(
                                context,
                                label: 'Protein',
                                unit: 'g',
                                value: summary.totalProtein,
                                maxValue: macro['protein']! * 7,
                              ),
                              _buildNutritionItem(
                                context,
                                label: 'Lemak',
                                unit: 'g',
                                value: summary.totalFat,
                                maxValue: macro['fat']! * 7,
                              ),
                              _buildNutritionItem(
                                context,
                                label: 'Gula',
                                unit: 'g',
                                value: summary.totalSugars,
                                maxValue: recSugars * 7,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          // Default empty widget for other states (initial, etc.)
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
