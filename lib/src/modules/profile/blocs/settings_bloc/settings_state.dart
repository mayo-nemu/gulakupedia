part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const SettingsState._();
  const factory SettingsState.initial() = _Initial;
  const factory SettingsState.failure(String errorMessage) = _Failure;
  const factory SettingsState.loading() = _Loading;
  const factory SettingsState.success() = _Success;

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
