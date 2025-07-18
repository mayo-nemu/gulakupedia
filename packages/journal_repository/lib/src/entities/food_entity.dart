import 'package:json_annotation/json_annotation.dart';

part 'food_entity.g.dart';

@JsonSerializable()
class FoodEntity {
  final String name;

  @JsonKey(name: 'serving_size_gram')
  final double servingSizeGram;

  @JsonKey(name: 'calories_100g')
  final double calories100g;

  @JsonKey(name: 'protein_100g')
  final double protein100g;

  @JsonKey(name: 'fat_100g')
  final double fat100g;

  @JsonKey(name: 'sugars_100g')
  final double sugars100g;

  @JsonKey(name: 'quantity_gram')
  final double quantityGram;

  FoodEntity({
    required this.name,
    required this.servingSizeGram,
    required this.calories100g,
    required this.protein100g,
    required this.fat100g,
    required this.sugars100g,
    required this.quantityGram,
  });

  factory FoodEntity.fromJson(Map<String, dynamic> json) =>
      _$FoodEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FoodEntityToJson(this);
}
