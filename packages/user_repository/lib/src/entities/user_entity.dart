import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:user_repository/src/utilities/timestamp_converter.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class MyUserEntity {
  @JsonKey(name: 'user_id')
  final String userId;

  final String email;

  @TimestampConverter()
  final DateTime birthday;

  final String name;

  final String gender;

  final double weight;

  final double height;

  final String activities;

  @JsonKey(name: 'blood_sugars')
  final double bloodSugars;

  @JsonKey(name: 'is_profile_complete')
  final bool isProfileComplete;

  @JsonKey(name: 'has_premium_account')
  final bool hasPremiumAccount;

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.weight,
    required this.height,
    required this.activities,
    required this.bloodSugars,
    required this.isProfileComplete,
    required this.hasPremiumAccount,
  });

  factory MyUserEntity.fromJson(Map<String, dynamic> json) =>
      _$MyUserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserEntityToJson(this);
}
