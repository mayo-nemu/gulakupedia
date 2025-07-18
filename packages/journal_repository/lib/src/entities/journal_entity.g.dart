// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalEntity _$JournalEntityFromJson(Map<String, dynamic> json) =>
    JournalEntity(
      date: const TimestampConverter().fromJson(json['date'] as Timestamp),
      sugarsGoal: (json['sugars_goal'] as num).toDouble(),
      hasMeals: json['has_meals'] as bool,
    );

Map<String, dynamic> _$JournalEntityToJson(JournalEntity instance) =>
    <String, dynamic>{
      'date': const TimestampConverter().toJson(instance.date),
      'sugars_goal': instance.sugarsGoal,
      'has_meals': instance.hasMeals,
    };
