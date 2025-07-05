// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent()';
}


}

/// @nodoc
class $SettingsEventCopyWith<$Res>  {
$SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}


/// @nodoc


class _UpdatePassword implements SettingsEvent {
  const _UpdatePassword(this.oldPassword, this.newPassword);
  

 final  String oldPassword;
 final  String newPassword;

/// Create a copy of SettingsEvent
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
  return 'SettingsEvent.updatePassword(oldPassword: $oldPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$UpdatePasswordCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
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

/// Create a copy of SettingsEvent
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


class _UpdateUserData implements SettingsEvent {
  const _UpdateUserData(this.myUser);
  

 final  MyUser myUser;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUserDataCopyWith<_UpdateUserData> get copyWith => __$UpdateUserDataCopyWithImpl<_UpdateUserData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserData&&(identical(other.myUser, myUser) || other.myUser == myUser));
}


@override
int get hashCode => Object.hash(runtimeType,myUser);

@override
String toString() {
  return 'SettingsEvent.updateUserData(myUser: $myUser)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserDataCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$UpdateUserDataCopyWith(_UpdateUserData value, $Res Function(_UpdateUserData) _then) = __$UpdateUserDataCopyWithImpl;
@useResult
$Res call({
 MyUser myUser
});


$MyUserCopyWith<$Res> get myUser;

}
/// @nodoc
class __$UpdateUserDataCopyWithImpl<$Res>
    implements _$UpdateUserDataCopyWith<$Res> {
  __$UpdateUserDataCopyWithImpl(this._self, this._then);

  final _UpdateUserData _self;
  final $Res Function(_UpdateUserData) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? myUser = null,}) {
  return _then(_UpdateUserData(
null == myUser ? _self.myUser : myUser // ignore: cast_nullable_to_non_nullable
as MyUser,
  ));
}

/// Create a copy of SettingsEvent
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
mixin _$SettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState()';
}


}

/// @nodoc
class $SettingsStateCopyWith<$Res>  {
$SettingsStateCopyWith(SettingsState _, $Res Function(SettingsState) __);
}


/// @nodoc


class _Initial extends SettingsState {
  const _Initial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.initial()';
}


}




/// @nodoc


class _Failure extends SettingsState {
  const _Failure(this.errorMessage): super._();
  

 final  String errorMessage;

/// Create a copy of SettingsState
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
  return 'SettingsState.failure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
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

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_Failure(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Loading extends SettingsState {
  const _Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.loading()';
}


}




/// @nodoc


class _Success extends SettingsState {
  const _Success(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.success()';
}


}




// dart format on
