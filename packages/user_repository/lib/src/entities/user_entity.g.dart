// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUserEntity _$MyUserEntityFromJson(Map<String, dynamic> json) => MyUserEntity(
  userId: json['user_id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  birthday: const TimestampConverter().fromJson(json['birthday'] as Timestamp),
  gender: json['gender'] as String,
  weight: (json['weight'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  activities: json['activities'] as String,
  bloodSugars: (json['blood_sugars'] as num).toDouble(),
  hasPremiumAccount: json['has_premium_account'] as bool,
);

Map<String, dynamic> _$MyUserEntityToJson(MyUserEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'email': instance.email,
      'birthday': const TimestampConverter().toJson(instance.birthday),
      'name': instance.name,
      'gender': instance.gender,
      'weight': instance.weight,
      'height': instance.height,
      'activities': instance.activities,
      'blood_sugars': instance.bloodSugars,
      'has_premium_account': instance.hasPremiumAccount,
    };
