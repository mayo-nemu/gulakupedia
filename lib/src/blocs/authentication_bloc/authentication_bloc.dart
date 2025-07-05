import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<MyUser?> _userSubscription;

  AuthenticationBloc({required this.userRepository}) : super(_Unknown()) {
    _userSubscription = userRepository.user.listen((myUser) {
      add(AuthenticationEvent.userChanged(myUser));
    });
    on<_UserChanged>((event, emit) async {
      if (event.myUser != MyUser.empty()) {
        emit(AuthenticationState.authenticated(event.myUser!));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
