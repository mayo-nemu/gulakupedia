import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:journal_repository/src/utilities/timestamp_converter.dart';

part 'journal_entity.g.dart';

@JsonSerializable()
class JournalEntity {
  @TimestampConverter()
  final DateTime date;

  @JsonKey(name: 'sugars_goal')
  final double sugarsGoal;

  @JsonKey(name: 'has_meals')
  final bool hasMeals;

  JournalEntity({
    required this.date,
    required this.sugarsGoal,
    required this.hasMeals,
  });

  factory JournalEntity.fromJson(Map<String, dynamic> json) =>
      _$JournalEntityFromJson(json);

  Map<String, dynamic> toJson() => _$JournalEntityToJson(this);
}
