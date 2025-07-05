// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodEntity _$FoodEntityFromJson(Map<String, dynamic> json) => FoodEntity(
  id: json['id'] as String,
  name: json['name'] as String,
  servingWeightGram: (json['serving_weight_gram'] as num).toDouble(),
  calories100Gram: (json['calories_100g'] as num).toDouble(),
  proteins100Gram: (json['proteins_100g'] as num).toDouble(),
  fats100Gram: (json['fats_100g'] as num).toDouble(),
  sugars100Gram: (json['sugars_100g'] as num).toDouble(),
  quantity: (json['quantity'] as num).toDouble(),
);

Map<String, dynamic> _$FoodEntityToJson(FoodEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'serving_weight_gram': instance.servingWeightGram,
      'calories_100g': instance.calories100Gram,
      'proteins_100g': instance.proteins100Gram,
      'fats_100g': instance.fats100Gram,
      'sugars_100g': instance.sugars100Gram,
      'quantity': instance.quantity,
    };
