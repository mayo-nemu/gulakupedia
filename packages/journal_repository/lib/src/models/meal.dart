import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal_repository/src/entities/entities.dart';

part 'meal.freezed.dart';

@freezed
abstract class Meal with _$Meal {
  const Meal._();

  const factory Meal({
    required String id,
    String? journalId,
    required String name,
    required double totalCaloriesGram,
    required double totalProteinGram,
    required double totalFatGram,
    required double totalSugarsGram,
    required bool hasFoods,
  }) = _Meal;

  static Meal empty() {
    return Meal(
      id: '',
      journalId: '',
      name: 'N/A',
      totalCaloriesGram: 0,
      totalProteinGram: 0,
      totalFatGram: 0,
      totalSugarsGram: 0,
      hasFoods: false,
    );
  }

  static Meal fromEntity(MealEntity entity, String id, String journalId) {
    return Meal(
      id: id,
      journalId: journalId,
      name: entity.name,
      totalCaloriesGram: entity.totalCaloriesGram,
      totalProteinGram: entity.totalProteinGram,
      totalFatGram: entity.totalFatGram,
      totalSugarsGram: entity.totalSugarsGram,
      hasFoods: entity.hasFoods,
    );
  }

  MealEntity toEntity() {
    return MealEntity(
      name: name,
      totalCaloriesGram: totalCaloriesGram,
      totalProteinGram: totalProteinGram,
      totalFatGram: totalFatGram,
      totalSugarsGram: totalSugarsGram,
      hasFoods: hasFoods,
    );
  }
}
