import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  SignUpBloc(this._userRepository) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpLoading());
      try {
        MyUser myUser = await _userRepository.signUp(
          event.user,
          event.password,
        );
        await _userRepository.setUserData(myUser);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure('Sign Up Failed: ${e.toString()}'));
      }
    });
    on<ProfileSetupRequired>((event, emit) async {
      emit(SignUpLoading());
      try {
        await _userRepository.setUserData(event.user);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure('Sign Up Failed: ${e.toString()}'));
      }
    });
  }
}
