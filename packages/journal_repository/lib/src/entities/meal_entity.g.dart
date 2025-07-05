// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealEntity _$MealEntityFromJson(Map<String, dynamic> json) => MealEntity(
  id: json['id'] as String,
  name: json['name'] as String,
  totalCaloriesGram: (json['total_calories_gram'] as num).toDouble(),
  totalProteinsGram: (json['total_proteins_gram'] as num).toDouble(),
  totalFatsGram: (json['total_fats_gram'] as num).toDouble(),
  totalSugarsGram: (json['total_sugars_gram'] as num).toDouble(),
  foods: (json['foods'] as List<dynamic>)
      .map((e) => FoodEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MealEntityToJson(MealEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'total_calories_gram': instance.totalCaloriesGram,
      'total_proteins_gram': instance.totalProteinsGram,
      'total_fats_gram': instance.totalFatsGram,
      'total_sugars_gram': instance.totalSugarsGram,
      'foods': instance.foods,
    };
