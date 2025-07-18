part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final MyUser user;
  final String password;

  const SignUpRequired(this.user, this.password);

  @override
  List<Object> get props => [user, password];
}

class ProfileSetupRequired extends SignUpEvent {
  final MyUser user;

  const ProfileSetupRequired(this.user);

  @override
  List<Object> get props => [user];
}
