part of 'profile_settings_bloc.dart';

sealed class ProfileSettingsState extends Equatable {
  const ProfileSettingsState();

  @override
  List<Object> get props => [];
}

final class ProfileSettingsInitial extends ProfileSettingsState {}

final class ProfileSettingsFailure extends ProfileSettingsState {
  final String errorMessage;

  const ProfileSettingsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class ProfileSettingsLoading extends ProfileSettingsState {}

final class ProfileSettingsSuccess extends ProfileSettingsState {}
