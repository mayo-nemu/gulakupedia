import 'package:json_annotation/json_annotation.dart';
import 'food_entity.dart';

part 'meal_entity.g.dart';

@JsonSerializable()
class MealEntity {
  final String id;

  final String name;

  @JsonKey(name: 'total_calories_gram')
  final double totalCaloriesGram;

  @JsonKey(name: 'total_proteins_gram')
  final double totalProteinsGram;

  @JsonKey(name: 'total_fats_gram')
  final double totalFatsGram;

  @JsonKey(name: 'total_sugars_gram')
  final double totalSugarsGram;

  final List<FoodEntity> foods;

  MealEntity({
    required this.id,
    required this.name,
    required this.totalCaloriesGram,
    required this.totalProteinsGram,
    required this.totalFatsGram,
    required this.totalSugarsGram,
    required this.foods,
  });

  factory MealEntity.fromJson(Map<String, dynamic> json) =>
      _$MealEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MealEntityToJson(this);
}
