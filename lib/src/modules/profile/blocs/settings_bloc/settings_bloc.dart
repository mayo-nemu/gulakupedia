import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserRepository _userRepository;
  SettingsBloc(this._userRepository) : super(_Initial()) {
    on<_UpdatePassword>((event, emit) async {
      emit(SettingsState.loading());
      try {
        emit(SettingsState.success());
      } catch (e) {
        emit(SettingsState.failure(e.toString()));
      }
    });
    on<_UpdateUserData>((event, emit) async {
      emit(SettingsState.loading());
      try {
        await _userRepository.setUserData(event.myUser);
        emit(SettingsState.success());
      } catch (e) {
        emit(SettingsState.failure(e.toString()));
      }
    });
  }
}
