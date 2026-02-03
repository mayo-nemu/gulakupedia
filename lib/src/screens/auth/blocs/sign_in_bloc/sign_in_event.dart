part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;

  const SignInRequired(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class UpdatePassword extends SignInEvent {
  final String oldPassword;
  final String newPassword;

  const UpdatePassword(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class SignOutRequired extends SignInEvent {}
