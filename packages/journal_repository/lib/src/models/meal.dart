import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal_repository/src/entities/entities.dart';
import 'food.dart';

part 'meal.freezed.dart';

@freezed
abstract class Meal with _$Meal {
  const Meal._();

  const factory Meal({
    required String id,
    required String name,
    required double totalCaloriesGram,
    required double totalProteinsGram,
    required double totalFatsGram,
    required double totalSugarsGram,
    required List<Food> foods,
  }) = _Meal;

  static Meal empty() {
    return Meal(
      id: '',
      name: '',
      totalCaloriesGram: 0,
      totalProteinsGram: 0,
      totalFatsGram: 0,
      totalSugarsGram: 0,
      foods: [],
    );
  }

  static Meal fromEntity(MealEntity entity) {
    return Meal(
      id: entity.id,
      name: entity.name,
      totalCaloriesGram: entity.totalCaloriesGram,
      totalProteinsGram: entity.totalProteinsGram,
      totalFatsGram: entity.totalFatsGram,
      totalSugarsGram: entity.totalSugarsGram,
      foods: entity.foods
          .map((foodEntity) => Food.fromEntity(foodEntity))
          .toList(),
    );
  }

  MealEntity toEntity() {
    return MealEntity(
      id: id,
      name: name,
      totalCaloriesGram: totalCaloriesGram,
      totalProteinsGram: totalProteinsGram,
      totalFatsGram: totalFatsGram,
      totalSugarsGram: totalSugarsGram,
      foods: foods.map((food) => food.toEntity()).toList(),
    );
  }
}
