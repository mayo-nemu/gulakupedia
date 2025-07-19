part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  final AuthenticationStatus status;
  final MyUser? user;

  bool get isProfileComplete => user != null && user!.isProfileComplete;

  const AuthenticationState.authenticated(MyUser myUser)
    : this._(status: AuthenticationStatus.authenticated, user: myUser);

  const AuthenticationState.unathenticated()
    : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.unkown() : this._();

  @override
  List<Object?> get props => [status, user];
}
