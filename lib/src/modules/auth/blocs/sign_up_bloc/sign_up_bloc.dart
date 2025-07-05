import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_bloc.freezed.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc(this._userRepository) : super(_Initial()) {
    on<_SignUpRequired>((event, emit) async {
      emit(SignUpState.loading());
      try {
        MyUser user = await _userRepository.signUp(
          event.myUser,
          event.password,
        );
        await _userRepository.setUserData(user);
        emit(SignUpState.success());
      } catch (e) {
        emit(SignUpState.failure(e.toString()));
      }
    });
  }
}
