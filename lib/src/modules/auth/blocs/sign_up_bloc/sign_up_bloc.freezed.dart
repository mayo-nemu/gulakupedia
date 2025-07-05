// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent()';
}


}

/// @nodoc
class $SignUpEventCopyWith<$Res>  {
$SignUpEventCopyWith(SignUpEvent _, $Res Function(SignUpEvent) __);
}


/// @nodoc


class _SignUpRequired implements SignUpEvent {
  const _SignUpRequired(this.myUser, this.password);
  

 final  MyUser myUser;
 final  String password;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpRequiredCopyWith<_SignUpRequired> get copyWith => __$SignUpRequiredCopyWithImpl<_SignUpRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpRequired&&(identical(other.myUser, myUser) || other.myUser == myUser)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,myUser,password);

@override
String toString() {
  return 'SignUpEvent.signUpRequired(myUser: $myUser, password: $password)';
}


}

/// @nodoc
abstract mixin class _$SignUpRequiredCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$SignUpRequiredCopyWith(_SignUpRequired value, $Res Function(_SignUpRequired) _then) = __$SignUpRequiredCopyWithImpl;
@useResult
$Res call({
 MyUser myUser, String password
});


$MyUserCopyWith<$Res> get myUser;

}
/// @nodoc
class __$SignUpRequiredCopyWithImpl<$Res>
    implements _$SignUpRequiredCopyWith<$Res> {
  __$SignUpRequiredCopyWithImpl(this._self, this._then);

  final _SignUpRequired _self;
  final $Res Function(_SignUpRequired) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? myUser = null,Object? password = null,}) {
  return _then(_SignUpRequired(
null == myUser ? _self.myUser : myUser // ignore: cast_nullable_to_non_nullable
as MyUser,null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyUserCopyWith<$Res> get myUser {
  
  return $MyUserCopyWith<$Res>(_self.myUser, (value) {
    return _then(_self.copyWith(myUser: value));
  });
}
}

/// @nodoc


class _UpdateProfile implements SignUpEvent {
  const _UpdateProfile(this.myUser);
  

 final  MyUser myUser;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateProfileCopyWith<_UpdateProfile> get copyWith => __$UpdateProfileCopyWithImpl<_UpdateProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateProfile&&(identical(other.myUser, myUser) || other.myUser == myUser));
}


@override
int get hashCode => Object.hash(runtimeType,myUser);

@override
String toString() {
  return 'SignUpEvent.updateProfile(myUser: $myUser)';
}


}

/// @nodoc
abstract mixin class _$UpdateProfileCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$UpdateProfileCopyWith(_UpdateProfile value, $Res Function(_UpdateProfile) _then) = __$UpdateProfileCopyWithImpl;
@useResult
$Res call({
 MyUser myUser
});


$MyUserCopyWith<$Res> get myUser;

}
/// @nodoc
class __$UpdateProfileCopyWithImpl<$Res>
    implements _$UpdateProfileCopyWith<$Res> {
  __$UpdateProfileCopyWithImpl(this._self, this._then);

  final _UpdateProfile _self;
  final $Res Function(_UpdateProfile) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? myUser = null,}) {
  return _then(_UpdateProfile(
null == myUser ? _self.myUser : myUser // ignore: cast_nullable_to_non_nullable
as MyUser,
  ));
}

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyUserCopyWith<$Res> get myUser {
  
  return $MyUserCopyWith<$Res>(_self.myUser, (value) {
    return _then(_self.copyWith(myUser: value));
  });
}
}

/// @nodoc


class _UpdatePassword implements SignUpEvent {
  const _UpdatePassword(this.oldPassword, this.newPassword);
  

 final  String oldPassword;
 final  String newPassword;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatePasswordCopyWith<_UpdatePassword> get copyWith => __$UpdatePasswordCopyWithImpl<_UpdatePassword>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatePassword&&(identical(other.oldPassword, oldPassword) || other.oldPassword == oldPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}


@override
int get hashCode => Object.hash(runtimeType,oldPassword,newPassword);

@override
String toString() {
  return 'SignUpEvent.updatePassword(oldPassword: $oldPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$UpdatePasswordCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory _$UpdatePasswordCopyWith(_UpdatePassword value, $Res Function(_UpdatePassword) _then) = __$UpdatePasswordCopyWithImpl;
@useResult
$Res call({
 String oldPassword, String newPassword
});




}
/// @nodoc
class __$UpdatePasswordCopyWithImpl<$Res>
    implements _$UpdatePasswordCopyWith<$Res> {
  __$UpdatePasswordCopyWithImpl(this._self, this._then);

  final _UpdatePassword _self;
  final $Res Function(_UpdatePassword) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldPassword = null,Object? newPassword = null,}) {
  return _then(_UpdatePassword(
null == oldPassword ? _self.oldPassword : oldPassword // ignore: cast_nullable_to_non_nullable
as String,null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SignUpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState()';
}


}

/// @nodoc
class $SignUpStateCopyWith<$Res>  {
$SignUpStateCopyWith(SignUpState _, $Res Function(SignUpState) __);
}


/// @nodoc


class _Initial extends SignUpState {
  const _Initial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState.initial()';
}


}




/// @nodoc


class _Failure extends SignUpState {
  const _Failure(this.errorMessage): super._();
  

 final  String errorMessage;

/// Create a copy of SignUpState
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
  return 'SignUpState.failure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
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

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_Failure(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Loading extends SignUpState {
  const _Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState.loading()';
}


}




/// @nodoc


class _Success extends SignUpState {
  const _Success(this.myUser): super._();
  

 final  MyUser? myUser;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.myUser, myUser) || other.myUser == myUser));
}


@override
int get hashCode => Object.hash(runtimeType,myUser);

@override
String toString() {
  return 'SignUpState.success(myUser: $myUser)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 MyUser? myUser
});


$MyUserCopyWith<$Res>? get myUser;

}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? myUser = freezed,}) {
  return _then(_Success(
freezed == myUser ? _self.myUser : myUser // ignore: cast_nullable_to_non_nullable
as MyUser?,
  ));
}

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyUserCopyWith<$Res>? get myUser {
    if (_self.myUser == null) {
    return null;
  }

  return $MyUserCopyWith<$Res>(_self.myUser!, (value) {
    return _then(_self.copyWith(myUser: value));
  });
}
}

// dart format on
