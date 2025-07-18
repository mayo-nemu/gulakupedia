import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal_repository/src/entities/entities.dart';

part 'journal.freezed.dart';

@freezed
abstract class Journal with _$Journal {
  const Journal._();
  const factory Journal({
    required String id,
    required DateTime date,
    required double sugarsGoal,
    required bool hasMeals,
  }) = _Journal;

  static DateTime get defaultDate => DateTime.fromMillisecondsSinceEpoch(0);

  static Journal empty() {
    return Journal(
      id: '',
      date: Journal.defaultDate,
      sugarsGoal: 30,
      hasMeals: false,
    );
  }

  static Journal fromEntity(JournalEntity entity, String id) {
    return Journal(
      id: id,
      date: entity.date,
      sugarsGoal: entity.sugarsGoal,
      hasMeals: entity.hasMeals,
    );
  }

  JournalEntity toEntity() {
    return JournalEntity(
      date: date,
      sugarsGoal: sugarsGoal,
      hasMeals: hasMeals,
    );
  }
}
