import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc(this._userRepository) : super(_Initial()) {
    on<_SignInRequired>((event, emit) async {
      emit(SignInState.loading());
      final result = await _userRepository.signIn(event.email, event.password);
      result.fold(
        (failure) => emit(SignInState.failure(failure.message)),
        (_) => emit(SignInState.success()),
      );
    });
    on<_SignOutRequired>((event, emit) async {
      final result = await _userRepository.logOut();
      result.fold(
        (failure) => emit(SignInState.failure(failure.message)),
        (_) => emit(SignInState.success()),
      );
    });
  }
}
