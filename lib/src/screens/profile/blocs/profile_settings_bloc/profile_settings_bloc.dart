import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  final UserRepository _userRepository;

  ProfileSettingsBloc(this._userRepository) : super(ProfileSettingsInitial()) {
    on<UpdatePassword>((event, emit) async {
      emit(ProfileSettingsLoading());
      try {
        await _userRepository.changeUserPassword(
          event.email,
          event.oldPassword,
          event.newPassword,
        );
        emit(ProfileSettingsSuccess());
      } catch (e) {
        emit(
          ProfileSettingsFailure('Failed to change password: ${e.toString()}'),
        );
      }
    });
    on<UpdateProfile>((event, emit) async {
      emit(ProfileSettingsLoading());
      try {
        await _userRepository.setUserData(event.user);
        emit(ProfileSettingsSuccess());
      } catch (e) {
        emit(
          ProfileSettingsFailure('Failed to update profile: ${e.toString()}'),
        );
      }
    });
    on<SignOutRequired>((event, emit) async => await _userRepository.logOut());
  }
}
