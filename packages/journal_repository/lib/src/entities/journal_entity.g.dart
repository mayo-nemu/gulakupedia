// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalEntity _$JournalEntityFromJson(Map<String, dynamic> json) =>
    JournalEntity(
      id: json['id'] as String,
      date: const TimestampConverter().fromJson(json['date'] as Timestamp),
      sugarsGoal: (json['sugarsGoal'] as num).toDouble(),
      meals: (json['meals'] as List<dynamic>)
          .map((e) => MealEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JournalEntityToJson(JournalEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': const TimestampConverter().toJson(instance.date),
      'sugarsGoal': instance.sugarsGoal,
      'meals': instance.meals,
    };
