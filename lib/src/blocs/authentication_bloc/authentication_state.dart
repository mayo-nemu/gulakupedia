part of 'authentication_bloc.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();
  const factory AuthenticationState.authenticated(MyUser myUser) =
      _Authenticated;
  const factory AuthenticationState.unauthenticated() = _Unauthenticated;
  const factory AuthenticationState.unknown() = _Unknown;

  bool get isAuthenticated => this is _Authenticated;
  bool get isUnauthenticated => this is _Unauthenticated;
  bool get isUnknown => this is _Unknown;

  MyUser? get userOrNull {
    if (this case _Authenticated(:final myUser)) {
      return myUser;
    }
    return null;
  }
}
