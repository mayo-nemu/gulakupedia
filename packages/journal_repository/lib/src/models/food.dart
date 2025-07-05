import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal_repository/src/entities/entities.dart';

part 'food.freezed.dart';

@freezed
abstract class Food with _$Food {
  const Food._();

  const factory Food({
    required String id,
    required String name,
    required double servingWeightGram,
    required double calories100Gram,
    required double proteins100Gram,
    required double fats100Gram,
    required double sugars100Gram,
    required double quantity,
  }) = _Food;

  static Food empty() {
    return Food(
      id: '',
      name: '',
      servingWeightGram: 0,
      calories100Gram: 0,
      proteins100Gram: 0,
      fats100Gram: 0,
      sugars100Gram: 0,
      quantity: 0,
    );
  }

  static Food fromEntity(FoodEntity entity) {
    return Food(
      id: entity.id,
      name: entity.name,
      servingWeightGram: entity.servingWeightGram,
      calories100Gram: entity.calories100Gram,
      proteins100Gram: entity.proteins100Gram,
      fats100Gram: entity.fats100Gram,
      sugars100Gram: entity.sugars100Gram,
      quantity: entity.quantity,
    );
  }

  FoodEntity toEntity() {
    return FoodEntity(
      id: id,
      name: name,
      servingWeightGram: servingWeightGram,
      calories100Gram: calories100Gram,
      proteins100Gram: proteins100Gram,
      fats100Gram: fats100Gram,
      sugars100Gram: sugars100Gram,
      quantity: quantity,
    );
  }
}
