import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:journal_repository/src/entities/entities.dart';
import 'package:journal_repository/src/models/models.dart';
import 'package:journal_repository/src/journal_repo.dart';

class FirebaseJournalRepo implements JournalRepository {
  FirebaseJournalRepo();

  final userCollection = FirebaseFirestore.instance.collection(
    'artifacts/gulapedia/users',
  );

  CollectionReference<JournalEntity> _getJournalCollection(String userId) {
    return userCollection
        .doc(userId)
        .collection('journals')
        .withConverter<JournalEntity>(
          fromFirestore: (snapshot, _) =>
              JournalEntity.fromJson(snapshot.data()!),
          toFirestore: (journalEntity, _) => journalEntity.toJson(),
        );
  }

  CollectionReference<MealEntity> _getMealCollection(
    String userId,
    String journalId,
  ) {
    return _getJournalCollection(userId)
        .doc(journalId)
        .collection('meals')
        .withConverter<MealEntity>(
          fromFirestore: (snapshot, _) => MealEntity.fromJson(snapshot.data()!),
          toFirestore: (mealEntity, _) => mealEntity.toJson(),
        );
  }

  CollectionReference<FoodEntity> _getFoodCollection(
    String userId,
    String journalId,
    String mealId,
  ) {
    return _getMealCollection(userId, journalId)
        .doc(mealId)
        .collection('foods')
        .withConverter<FoodEntity>(
          fromFirestore: (snapshot, _) => FoodEntity.fromJson(snapshot.data()!),
          toFirestore: (foodEntity, _) => foodEntity.toJson(),
        );
  }

  @override
  Future<Journal> getThisJournal(String userId, DateTime thisDate) async {
    final startOfDay = DateTime(thisDate.year, thisDate.month, thisDate.day);
    final endOfDay = DateTime(
      thisDate.year,
      thisDate.month,
      thisDate.day,
      23,
      59,
      59,
      999,
    );

    try {
      final journalQuery = await _getJournalCollection(userId)
          .where('date', isGreaterThanOrEqualTo: startOfDay)
          .where('date', isLessThanOrEqualTo: endOfDay)
          .limit(1)
          .get();

      if (journalQuery.docs.isNotEmpty) {
        final doc = journalQuery.docs.first;
        return Journal.fromEntity(doc.data(), doc.id);
      } else {
        final newJournal = Journal.empty().copyWith(date: startOfDay);

        final docRef = await _getJournalCollection(
          userId,
        ).add(newJournal.toEntity());

        final newJournalSnapshot = await docRef.get();
        return Journal.fromEntity(
          newJournalSnapshot.data()!,
          newJournalSnapshot.id,
        );
      }
    } catch (e, st) {
      log(
        'Error getting or creating journal for date: $thisDate, User: $userId - $e',
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<List<Journal>> getThisWeekJournals(
    String userId,
    DateTime thisDate,
  ) async {
    final now = thisDate;
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1)); // Monday
    final endOfWeek = DateTime(now.year, now.month, now.day).add(
      const Duration(
        days: 6,
        hours: 23,
        minutes: 59,
        seconds: 59,
        milliseconds: 999,
      ),
    ); // Sunday

    try {
      final journalQuery = await _getJournalCollection(userId)
          .where('date', isGreaterThanOrEqualTo: startOfWeek)
          .where('date', isLessThanOrEqualTo: endOfWeek)
          .orderBy('date') // Order by date for consistent results
          .get();

      return journalQuery.docs
          .map((doc) => Journal.fromEntity(doc.data(), doc.id))
          .toList();
    } catch (e, st) {
      log(
        'Error getting journals for this week for user: $userId - $e',
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<List<Journal>> getThisMonthJournals(
    String userId,
    DateTime thisDate,
  ) async {
    final startOfMonth = DateTime(thisDate.year, thisDate.month, 1);
    final endOfMonth = DateTime(
      thisDate.year,
      thisDate.month + 1,
      0,
      23,
      59,
      59,
      999,
    ); // Last day of the current month

    try {
      final journalQuery = await _getJournalCollection(userId)
          .where('date', isGreaterThanOrEqualTo: startOfMonth)
          .where('date', isLessThanOrEqualTo: endOfMonth)
          .orderBy('date') // Order by date
          .get();

      return journalQuery.docs
          .map((doc) => Journal.fromEntity(doc.data(), doc.id))
          .toList();
    } catch (e, st) {
      log(
        'Error getting journals for this month for user: $userId - $e',
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<List<Meal>> getThisJournalMeals(
    String userId,
    String journalId,
  ) async {
    try {
      final mealQuery = await _getMealCollection(userId, journalId).get();
      return mealQuery.docs
          .map((doc) => Meal.fromEntity(doc.data(), doc.id, journalId))
          .toList();
    } catch (e, st) {
      log(
        'Error getting meals: for journal $journalId, User: $userId - $e',
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<List<Meal>> getThisWeekAllMeals(
    String userId,
    DateTime thisDate,
  ) async {
    try {
      final List<Journal> weeklyJournals = await getThisWeekJournals(
        userId,
        thisDate,
      );

      // Fetch meals for each journal in parallel
      final List<Future<List<Meal>>> mealFutures = weeklyJournals.map((
        journal,
      ) {
        return getThisJournalMeals(userId, journal.id);
      }).toList();

      final List<List<Meal>> nestedMeals = await Future.wait(mealFutures);

      // Flatten the list of lists into a single list
      return nestedMeals.expand((meals) => meals).toList();
    } catch (e, st) {
      log(
        'Error getting all weekly meals for user: $userId - $e',
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<List<Meal>> getThisMonthAllMeals(
    String userId,
    DateTime thisDate,
  ) async {
    try {
      final List<Journal> monthlyJournals = await getThisMonthJournals(
        userId,
        thisDate,
      );

      // Fetch meals for each journal in parallel for the entire month
      final List<Future<List<Meal>>> mealFutures = monthlyJournals.map((
        journal,
      ) {
        return getThisJournalMeals(userId, journal.id);
      }).toList();

      final List<List<Meal>> nestedMeals = await Future.wait(mealFutures);

      // Flatten the list of lists into a single list
      return nestedMeals.expand((meals) => meals).toList();
    } catch (e, st) {
      log(
        'Error getting all monthly meals for user: $userId - $e',
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<Meal> getThisMeal(
    String userId,
    String journalId,
    String mealName,
  ) async {
    try {
      final mealQuery = await _getMealCollection(
        userId,
        journalId,
      ).where('name', isEqualTo: mealName).limit(1).get();

      if (mealQuery.docs.isNotEmpty) {
        final doc = mealQuery.docs.first;

        return Meal.fromEntity(doc.data(), doc.id, journalId);
      } else {
        // When creating a new meal, ensure journalId is set
        final newMeal = Meal.empty().copyWith(
          name: mealName,
          journalId: journalId,
        );

        final docRef = await _getMealCollection(
          userId,
          journalId,
        ).add(newMeal.toEntity());

        await _getJournalCollection(
          userId,
        ).doc(journalId).update({'has_meals': true});

        final createdMealSnapshot = await docRef.get();
        return Meal.fromEntity(
          createdMealSnapshot.data()!,
          createdMealSnapshot.id,
          journalId,
        );
      }
    } catch (e, st) {
      log(
        'Error getting or creating meal: $mealName for journal $journalId, User: $userId - $e',
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<List<Food>> getThisMealFoods(
    String userId,
    String journalId,
    String mealId,
  ) async {
    try {
      final foodQuery = await _getFoodCollection(
        userId,
        journalId,
        mealId,
      ).get();

      return foodQuery.docs
          .map((doc) => Food.fromEntity(doc.data(), doc.id))
          .toList();
    } catch (e, st) {
      log(
        'Error getting or creating meal: $mealId for journal $journalId, User: $userId - $e',
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<void> addFoodToMeal(
    String userId,
    String journalId,
    String mealId,
    List<Food> foods,
  ) async {
    try {
      // 1. Get the current meal to update its totals
      final mealDocRef = _getMealCollection(userId, journalId).doc(mealId);
      final mealSnapshot = await mealDocRef.get();

      if (!mealSnapshot.exists) {
        throw Exception('Meal with ID $mealId not found.');
      }

      // Pass journalId to fromEntity
      Meal currentMeal = Meal.fromEntity(
        mealSnapshot.data()!,
        mealSnapshot.id,
        journalId,
      );

      // Initialize total nutrition values with current meal's values
      double newTotalCalories = currentMeal.totalCaloriesGram;
      double newTotalProtein = currentMeal.totalProteinGram;
      double newTotalFat = currentMeal.totalFatGram;
      double newTotalSugars = currentMeal.totalSugarsGram;

      // 2. Add each food to the meal's foods subcollection and update totals
      for (var food in foods) {
        await _getFoodCollection(
          userId,
          journalId,
          mealId,
        ).add(food.toEntity());

        final double factor = food.quantityGram / 100.0;
        newTotalCalories += food.calories100g * factor;
        newTotalProtein += food.protein100g * factor;
        newTotalFat += food.fat100g * factor;
        newTotalSugars += food.sugars100g * factor;
      }

      // 3. Update the meal document with the new totals and hasFoods flag
      await mealDocRef.update({
        'total_calories_gram': newTotalCalories,
        'total_protein_gram': newTotalProtein,
        'total_fat_gram': newTotalFat,
        'total_sugars_gram': newTotalSugars,
        'has_foods': true,
      });
    } catch (e, st) {
      log(
        'Error adding food to meal: $mealId for journal $journalId, User: $userId - $e',
        stackTrace: st,
      );
      rethrow;
    }
  }
}
