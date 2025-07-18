part of 'profile_settings_bloc.dart';

sealed class ProfileSettingsEvent extends Equatable {
  const ProfileSettingsEvent();

  @override
  List<Object> get props => [];
}

class UpdatePassword extends ProfileSettingsEvent {
  final String email;
  final String oldPassword;
  final String newPassword;

  const UpdatePassword(this.email, this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [email, oldPassword, newPassword];
}

class UpdateProfile extends ProfileSettingsEvent {
  final MyUser user;

  const UpdateProfile(this.user);

  @override
  List<Object> get props => [user];
}

class SignOutRequired extends ProfileSettingsEvent {}
