part of 'sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.signInRequired(String email, String password) =
      _SignInRequired;
  const factory SignInEvent.signOutRequired() = _SignOutRequired;
}
