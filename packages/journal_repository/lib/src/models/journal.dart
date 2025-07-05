import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal_repository/src/entities/entities.dart';
import 'meal.dart';

part 'journal.freezed.dart';

@freezed
abstract class Journal with _$Journal {
  const Journal._();

  const factory Journal({
    required String id,
    required DateTime date,
    required double sugarsGoal,
    required List<Meal> meals,
  }) = _Journal;

  static Journal empty() {
    return Journal(id: '', date: DateTime.now(), sugarsGoal: 0, meals: []);
  }

  static Journal fromEntity(JournalEntity entity) {
    return Journal(
      id: entity.id,
      date: entity.date,
      sugarsGoal: entity.sugarsGoal,
      meals: entity.meals.map((meal) => Meal.fromEntity(meal)).toList(),
    );
  }

  JournalEntity toEntity() {
    return JournalEntity(
      id: id,
      date: date,
      sugarsGoal: sugarsGoal,
      meals: meals.map((meal) => meal.toEntity()).toList(),
    );
  }
}
