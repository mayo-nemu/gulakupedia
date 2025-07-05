import 'package:journal_repository/src/utilities/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'meal_entity.dart';

part 'journal_entity.g.dart';

@JsonSerializable()
class JournalEntity {
  final String id;

  @TimestampConverter()
  final DateTime date;

  @JsonKey(name: 'sugarsGoal')
  final double sugarsGoal;

  final List<MealEntity> meals;

  JournalEntity({
    required this.id,
    required this.date,
    required this.sugarsGoal,
    required this.meals,
  });

  factory JournalEntity.fromJson(Map<String, dynamic> json) =>
      _$JournalEntityFromJson(json);

  Map<String, dynamic> toJson() => _$JournalEntityToJson(this);
}
