part of 'sign_in_bloc.dart';

@freezed
abstract class SignInState with _$SignInState {
  const SignInState._();
  const factory SignInState.initial() = _Initial;
  const factory SignInState.failure(String errorMessage) = _Failure;
  const factory SignInState.loading() = _Loading;
  const factory SignInState.success() = _Success;

  bool get isFailure => this is _Failure;
  bool get isLoading => this is _Loading;
  bool get isSuccess => this is _Success;

  String? get errorMessage {
    if (this is _Failure) {
      return (this as _Failure).errorMessage;
    }

    return null;
  }
}
