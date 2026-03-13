import 'package:journal_repository/journal_repository.dart';
import 'package:collection/collection.dart';

class WeeklyJournals {
  final DateTime startOfWeek;
  final DateTime endOfWeek;
  final List<Journal> journalsInWeek;
  final List<Meal> mealsInWeek;
  final double totalSugars;
  final double totalProtein;
  final double totalFat;
  final double totalCalories;

  WeeklyJournals({
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

class WeeklyJournalsViewModel {
  final List<Journal> monthlyJournals;
  final List<Meal> monthlyMeals;

  WeeklyJournalsViewModel({
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
  int getWeekNumber(DateTime date) {
    // Find the nearest Thursday to the given date.
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

  /// Generates a list of [WeeklyJournals] objects from the monthly data.
  List<WeeklyJournals> getWeeklyJournals() {
    final List<WeeklyJournals> journals = [];

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

      journals.add(
        WeeklyJournals(
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

    return journals;
  }
}

