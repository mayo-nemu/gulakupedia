part of 'sign_up_bloc.dart';

@freezed
abstract class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.signUpRequired(MyUser myUser, String password) =
      _SignUpRequired;
  const factory SignUpEvent.updateProfile(MyUser myUser) = _UpdateProfile;
  const factory SignUpEvent.updatePassword(
    String oldPassword,
    String newPassword,
  ) = _UpdatePassword;
}
