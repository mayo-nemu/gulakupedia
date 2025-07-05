import 'package:json_annotation/json_annotation.dart';

part 'food_entity.g.dart';

@JsonSerializable()
class FoodEntity {
  final String id;

  final String name;

  @JsonKey(name: 'serving_weight_gram')
  final double servingWeightGram;

  @JsonKey(name: 'calories_100g')
  final double calories100Gram;

  @JsonKey(name: 'proteins_100g')
  final double proteins100Gram;

  @JsonKey(name: 'fats_100g')
  final double fats100Gram;

  @JsonKey(name: 'sugars_100g')
  final double sugars100Gram;

  final double quantity;

  FoodEntity({
    required this.id,
    required this.name,
    required this.servingWeightGram,
    required this.calories100Gram,
    required this.proteins100Gram,
    required this.fats100Gram,
    required this.sugars100Gram,
    required this.quantity,
  });

  factory FoodEntity.fromJson(Map<String, dynamic> json) =>
      _$FoodEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FoodEntityToJson(this);
}
