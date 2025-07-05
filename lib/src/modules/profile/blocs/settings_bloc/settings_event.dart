part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.updatePassword(
    String oldPassword,
    String newPassword,
  ) = _UpdatePassword;
  const factory SettingsEvent.updateUserData(MyUser myUser) = _UpdateUserData;
}
