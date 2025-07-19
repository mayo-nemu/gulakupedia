import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<MyUser?> _userSubscription;

  AuthenticationBloc({required this.userRepository})
    : super(const AuthenticationState.unkown()) {
    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });
    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null && event.user != MyUser.empty()) {
        final newState = AuthenticationState.authenticated(event.user!);
        print(
          'AuthenticationBloc: User changed to authenticated. Is profile complete? ${newState.isProfileComplete}',
        );
        emit(AuthenticationState.authenticated(event.user!));
      } else {
        emit(const AuthenticationState.unathenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
