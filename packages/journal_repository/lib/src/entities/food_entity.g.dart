// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodEntity _$FoodEntityFromJson(Map<String, dynamic> json) => FoodEntity(
  name: json['name'] as String,
  servingSizeGram: (json['serving_size_gram'] as num).toDouble(),
  calories100g: (json['calories_100g'] as num).toDouble(),
  protein100g: (json['protein_100g'] as num).toDouble(),
  fat100g: (json['fat_100g'] as num).toDouble(),
  sugars100g: (json['sugars_100g'] as num).toDouble(),
  quantityGram: (json['quantity_gram'] as num).toDouble(),
);

Map<String, dynamic> _$FoodEntityToJson(FoodEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'serving_size_gram': instance.servingSizeGram,
      'calories_100g': instance.calories100g,
      'protein_100g': instance.protein100g,
      'fat_100g': instance.fat100g,
      'sugars_100g': instance.sugars100g,
      'quantity_gram': instance.quantityGram,
    };
