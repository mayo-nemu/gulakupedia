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
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInState.success());
      } catch (e) {
        emit(SignInState.failure(e.toString()));
      }
    });
    on<_SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
      emit(SignInState.success());
    });
  }
}
