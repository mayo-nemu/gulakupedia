// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInEvent()';
}


}

/// @nodoc
class $SignInEventCopyWith<$Res>  {
$SignInEventCopyWith(SignInEvent _, $Res Function(SignInEvent) __);
}


/// @nodoc


class _SignInRequired implements SignInEvent {
  const _SignInRequired(this.email, this.password);
  

 final  String email;
 final  String password;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInRequiredCopyWith<_SignInRequired> get copyWith => __$SignInRequiredCopyWithImpl<_SignInRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInRequired&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'SignInEvent.signInRequired(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$SignInRequiredCopyWith<$Res> implements $SignInEventCopyWith<$Res> {
  factory _$SignInRequiredCopyWith(_SignInRequired value, $Res Function(_SignInRequired) _then) = __$SignInRequiredCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$SignInRequiredCopyWithImpl<$Res>
    implements _$SignInRequiredCopyWith<$Res> {
  __$SignInRequiredCopyWithImpl(this._self, this._then);

  final _SignInRequired _self;
  final $Res Function(_SignInRequired) _then;

/// Create a copy of SignInEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_SignInRequired(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SignOutRequired implements SignInEvent {
  const _SignOutRequired();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignOutRequired);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInEvent.signOutRequired()';
}


}




/// @nodoc
mixin _$SignInState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInState()';
}


}

/// @nodoc
class $SignInStateCopyWith<$Res>  {
$SignInStateCopyWith(SignInState _, $Res Function(SignInState) __);
}


/// @nodoc


class _Initial extends SignInState {
  const _Initial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInState.initial()';
}


}




/// @nodoc


class _Failure extends SignInState {
  const _Failure(this.errorMessage): super._();
  

 final  String errorMessage;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'SignInState.failure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_Failure(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Loading extends SignInState {
  const _Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInState.loading()';
}


}




/// @nodoc


class _Success extends SignInState {
  const _Success(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInState.success()';
}


}




// dart format on
