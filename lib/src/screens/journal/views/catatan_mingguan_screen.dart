import 'package:journal_repository/journal_repository.dart';
import 'package:collection/collection.dart'; // For firstWhereOrNull, groupBy

// A simple class to hold aggregated weekly data
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

class WeeklySummaryViewModel {
  final List<Journal> monthlyJournals;
  final List<Meal> monthlyMeals;

  WeeklySummaryViewModel({
    required this.monthlyJournals,
    required this.monthlyMeals,
  });

  // Helper to get the start of the week (Monday) for a given date
  DateTime _getStartOfWeek(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(Duration(days: date.weekday - 1));
  }

  // Helper to get the end of the week (Sunday) for a given date
  DateTime _getEndOfWeek(DateTime date) {
    return _getStartOfWeek(date).add(
      const Duration(
        days: 6,
        hours: 23,
        minutes: 59,
        seconds: 59,
        milliseconds: 999,
      ),
    );
  }

  // Helper to check if two dates are in the same week
  bool _isSameWeek(DateTime date1, DateTime date2) {
    return _getStartOfWeek(date1).isAtSameMomentAs(_getStartOfWeek(date2));
  }

  List<WeeklySummary> get weeklySummaries {
    if (monthlyJournals.isEmpty) {
      return [];
    }

    // Group journals by week
    final Map<DateTime, List<Journal>> journalsGroupedByWeek = groupBy(
      monthlyJournals,
      (journal) => _getStartOfWeek(journal.date),
    );

    // Group meals by week (need to link meals back to their journal's week)
    // First, map meals to their respective journal IDs
    final Map<String, Journal> journalMap = {
      for (var journal in monthlyJournals) journal.id: journal,
    };

    final Map<DateTime, List<Meal>> mealsGroupedByWeek = {};
    for (var meal in monthlyMeals) {
      final journalId = meal.journalId;
      if (journalId != null && journalMap.containsKey(journalId)) {
        final journalDate = journalMap[journalId]!.date;
        final startOfWeek = _getStartOfWeek(journalDate);
        mealsGroupedByWeek.putIfAbsent(startOfWeek, () => []).add(meal);
      }
    }

    List<WeeklySummary> summaries = [];

    // Get all unique start of weeks from both journals and meals
    Set<DateTime> allWeekStarts = {};
    allWeekStarts.addAll(journalsGroupedByWeek.keys);
    allWeekStarts.addAll(mealsGroupedByWeek.keys);

    // Sort the week starts
    List<DateTime> sortedWeekStarts = allWeekStarts.toList()
      ..sort((a, b) => a.compareTo(b));

    for (var startOfWeek in sortedWeekStarts) {
      final endOfWeek = _getEndOfWeek(startOfWeek);
      final journalsInWeek = journalsGroupedByWeek[startOfWeek] ?? [];
      final mealsInWeek = mealsGroupedByWeek[startOfWeek] ?? [];

      // Calculate totals for the week
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
