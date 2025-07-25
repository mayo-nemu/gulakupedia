import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/src/entities/entities.dart';

part 'user.freezed.dart';

@freezed
abstract class MyUser with _$MyUser {
  const MyUser._();

  const factory MyUser({
    required String userId,
    required String email,
    required String name,
    required DateTime birthday,
    required String gender,
    required double weight,
    required double height,
    required String activities,
    required double bloodSugars,
    required bool isProfileComplete,
    required bool hasPremiumAccount,
  }) = _MyUser;

  static MyUser empty() {
    return MyUser(
      userId: '',
      email: '',
      name: '',
      birthday: MyUser.defaultBirthday,
      gender: '',
      weight: 0,
      height: 0,
      activities: '',
      bloodSugars: 0,
      isProfileComplete: false,
      hasPremiumAccount: false,
    );
  }

  static DateTime get defaultBirthday => DateTime.fromMillisecondsSinceEpoch(0);

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      birthday: entity.birthday,
      gender: entity.gender,
      weight: entity.weight,
      height: entity.height,
      activities: entity.activities,
      bloodSugars: entity.bloodSugars,
      isProfileComplete: entity.isProfileComplete,
      hasPremiumAccount: entity.hasPremiumAccount,
    );
  }

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      birthday: birthday,
      gender: gender,
      weight: weight,
      height: height,
      activities: activities,
      bloodSugars: bloodSugars,
      isProfileComplete: isProfileComplete,
      hasPremiumAccount: hasPremiumAccount,
    );
  }
}
