import 'package:journal_repository/src/models/models.dart';

abstract class JournalRepository {
  Future<Journal> getThisJournal(String userId, DateTime thisDate);
  Future<List<Journal>> getThisWeekJournals(String userId, DateTime thisDate);
  Future<List<Journal>> getThisMonthJournals(String userId, DateTime thisDate);
  Future<List<Meal>> getThisJournalMeals(String userId, String journalId);
  Future<List<Meal>> getThisWeekAllMeals(String userId, DateTime thisDate);
  Future<List<Meal>> getThisMonthAllMeals(String userId, DateTime thisDate);
  Future<Meal> getThisMeal(String userId, String journalId, String mealName);
  Future<List<Food>> getThisMealFoods(
    String userId,
    String journalId,
    String mealId,
  );
  Future<void> addFoodToMeal(
    String userId,
    String journalId,
    String mealId,
    List<Food> foods,
  );
}
