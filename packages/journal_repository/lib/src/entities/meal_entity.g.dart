// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealEntity _$MealEntityFromJson(Map<String, dynamic> json) => MealEntity(
  name: json['name'] as String,
  totalCaloriesGram: (json['total_calories_gram'] as num).toDouble(),
  totalProteinGram: (json['total_protein_gram'] as num).toDouble(),
  totalFatGram: (json['total_fat_gram'] as num).toDouble(),
  totalSugarsGram: (json['total_sugars_gram'] as num).toDouble(),
  hasFoods: json['has_foods'] as bool,
);

Map<String, dynamic> _$MealEntityToJson(MealEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'total_calories_gram': instance.totalCaloriesGram,
      'total_protein_gram': instance.totalProteinGram,
      'total_fat_gram': instance.totalFatGram,
      'total_sugars_gram': instance.totalSugarsGram,
      'has_foods': instance.hasFoods,
    };
