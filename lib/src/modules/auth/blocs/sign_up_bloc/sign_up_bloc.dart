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
        final signInResult = await _userRepository.signUp(
          event.myUser,
          event.password,
        );
        signInResult.fold(
          (failure) => emit(SignUpState.failure(failure.message)),
          (signedUpMyUser) async {
            final result = await _userRepository.setUserData(signedUpMyUser);
            result.fold(
              (failure) => emit(SignUpState.failure(failure.message)),
              (_) => emit(SignUpState.success(signedUpMyUser)),
            );
          },
        );
      } catch (e) {
        emit(SignUpState.failure(e.toString()));
      }
    });
    on<_UpdateProfile>((event, emit) async {
      emit(SignUpState.loading());
      try {
        final result = await _userRepository.setUserData(event.myUser);

        result.fold(
          (failure) => emit(SignUpState.failure(failure.message)),
          (_) => emit(SignUpState.success(event.myUser)),
        );
      } catch (e) {
        emit(SignUpState.failure(e.toString()));
      }
    });
    // --- END FIX ---
  }
}
