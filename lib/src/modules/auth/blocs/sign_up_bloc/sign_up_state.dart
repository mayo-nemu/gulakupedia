part of 'sign_up_bloc.dart';

@freezed
class SignUpState with _$SignUpState {
  const SignUpState._();
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.failure(String errorMessage) = _Failure;
  const factory SignUpState.loading() = _Loading;
  const factory SignUpState.success(MyUser? myUser) = _Success;

  bool get isFailure => this is _Failure;
  bool get isLoading => this is _Loading;
  bool get isSuccess => this is _Success;

  String? get errorMessage {
    if (this is _Failure) {
      return (this as _Failure).errorMessage;
    }

    return null;
  }

  MyUser? get myUser {
    if (this is _Success) {
      return (this as _Success).myUser;
    }

    return null;
  }
}
