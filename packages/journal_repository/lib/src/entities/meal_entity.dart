import 'package:json_annotation/json_annotation.dart';

part 'meal_entity.g.dart';

@JsonSerializable()
class MealEntity {
  final String name;

  @JsonKey(name: 'total_calories_gram')
  final double totalCaloriesGram;

  @JsonKey(name: 'total_protein_gram')
  final double totalProteinGram;

  @JsonKey(name: 'total_fat_gram')
  final double totalFatGram;

  @JsonKey(name: 'total_sugars_gram')
  final double totalSugarsGram;

  @JsonKey(name: 'has_foods')
  final bool hasFoods;

  MealEntity({
    required this.name,
    required this.totalCaloriesGram,
    required this.totalProteinGram,
    required this.totalFatGram,
    required this.totalSugarsGram,
    required this.hasFoods,
  });

  factory MealEntity.fromJson(Map<String, dynamic> json) =>
      _$MealEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MealEntityToJson(this);
}
