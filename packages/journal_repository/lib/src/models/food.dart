import 'package:journal_repository/src/entities/entities.dart';
import 'package:equatable/equatable.dart';

class Food extends Equatable {
  // Add a regular constructor
  const Food({
    required this.id,
    required this.name,
    required this.servingSizeGram,
    required this.calories100g,
    required this.protein100g,
    required this.fat100g,
    required this.sugars100g,
    required this.quantityGram,
  });

  final String id;
  final String name;
  final double servingSizeGram;
  final double calories100g;
  final double protein100g;
  final double fat100g;
  final double sugars100g;
  final double quantityGram;

  // This is the core of the solution: only compare by 'id'
  @override
  List<Object?> get props => [id];

  static Food empty() {
    return const Food(
      // Use const constructor if fields are final
      id: '',
      name: 'N/A',
      servingSizeGram: 0,
      calories100g: 0,
      protein100g: 0,
      fat100g: 0,
      sugars100g: 0,
      quantityGram: 0,
    );
  }

  static Food fromEntity(FoodEntity entity, String id) {
    return Food(
      id: id,
      name: entity.name,
      servingSizeGram: entity.servingSizeGram,
      calories100g: entity.calories100g,
      protein100g: entity.protein100g,
      fat100g: entity.fat100g,
      sugars100g: entity.sugars100g,
      quantityGram: entity.quantityGram,
    );
  }

  FoodEntity toEntity() {
    return FoodEntity(
      name: name,
      servingSizeGram: servingSizeGram,
      calories100g: calories100g,
      protein100g: protein100g,
      fat100g: fat100g,
      sugars100g: sugars100g,
      quantityGram: quantityGram,
    );
  }

  Food copyWith({
    String? id,
    String? name,
    double? servingSizeGram,
    double? calories100g,
    double? protein100g,
    double? fat100g,
    double? sugars100g,
    double? quantityGram,
  }) {
    return Food(
      id: id ?? this.id,
      name: name ?? this.name,
      servingSizeGram: servingSizeGram ?? this.servingSizeGram,
      calories100g: calories100g ?? this.calories100g,
      protein100g: protein100g ?? this.protein100g,
      fat100g: fat100g ?? this.fat100g,
      sugars100g: sugars100g ?? this.sugars100g,
      quantityGram: quantityGram ?? this.quantityGram,
    );
  }

  @override
  String toString() {
    return 'Food('
        'id: $id, '
        'name: $name, '
        'sugars100g: $sugars100g, '
        'quantityGram: $quantityGram'
        ')';
  }
}
