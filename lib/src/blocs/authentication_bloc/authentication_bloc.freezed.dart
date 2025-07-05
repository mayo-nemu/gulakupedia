// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthenticationEvent {

 MyUser? get myUser;
/// Create a copy of AuthenticationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationEventCopyWith<AuthenticationEvent> get copyWith => _$AuthenticationEventCopyWithImpl<AuthenticationEvent>(this as AuthenticationEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationEvent&&(identical(other.myUser, myUser) || other.myUser == myUser));
}


@override
int get hashCode => Object.hash(runtimeType,myUser);

@override
String toString() {
  return 'AuthenticationEvent(myUser: $myUser)';
}


}

/// @nodoc
abstract mixin class $AuthenticationEventCopyWith<$Res>  {
  factory $AuthenticationEventCopyWith(AuthenticationEvent value, $Res Function(AuthenticationEvent) _then) = _$AuthenticationEventCopyWithImpl;
@useResult
$Res call({
 MyUser? myUser
});


$MyUserCopyWith<$Res>? get myUser;

}
/// @nodoc
class _$AuthenticationEventCopyWithImpl<$Res>
    implements $AuthenticationEventCopyWith<$Res> {
  _$AuthenticationEventCopyWithImpl(this._self, this._then);

  final AuthenticationEvent _self;
  final $Res Function(AuthenticationEvent) _then;

/// Create a copy of AuthenticationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? myUser = freezed,}) {
  return _then(_self.copyWith(
myUser: freezed == myUser ? _self.myUser : myUser // ignore: cast_nullable_to_non_nullable
as MyUser?,
  ));
}
/// Create a copy of AuthenticationEvent
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


/// @nodoc


class _UserChanged implements AuthenticationEvent {
  const _UserChanged(this.myUser);
  

@override final  MyUser? myUser;

/// Create a copy of AuthenticationEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserChangedCopyWith<_UserChanged> get copyWith => __$UserChangedCopyWithImpl<_UserChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserChanged&&(identical(other.myUser, myUser) || other.myUser == myUser));
}


@override
int get hashCode => Object.hash(runtimeType,myUser);

@override
String toString() {
  return 'AuthenticationEvent.userChanged(myUser: $myUser)';
}


}

/// @nodoc
abstract mixin class _$UserChangedCopyWith<$Res> implements $AuthenticationEventCopyWith<$Res> {
  factory _$UserChangedCopyWith(_UserChanged value, $Res Function(_UserChanged) _then) = __$UserChangedCopyWithImpl;
@override @useResult
$Res call({
 MyUser? myUser
});


@override $MyUserCopyWith<$Res>? get myUser;

}
/// @nodoc
class __$UserChangedCopyWithImpl<$Res>
    implements _$UserChangedCopyWith<$Res> {
  __$UserChangedCopyWithImpl(this._self, this._then);

  final _UserChanged _self;
  final $Res Function(_UserChanged) _then;

/// Create a copy of AuthenticationEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? myUser = freezed,}) {
  return _then(_UserChanged(
freezed == myUser ? _self.myUser : myUser // ignore: cast_nullable_to_non_nullable
as MyUser?,
  ));
}

/// Create a copy of AuthenticationEvent
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

/// @nodoc
mixin _$AuthenticationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState()';
}


}

/// @nodoc
class $AuthenticationStateCopyWith<$Res>  {
$AuthenticationStateCopyWith(AuthenticationState _, $Res Function(AuthenticationState) __);
}


/// @nodoc


class _Authenticated extends AuthenticationState {
  const _Authenticated(this.myUser): super._();
  

 final  MyUser myUser;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticatedCopyWith<_Authenticated> get copyWith => __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authenticated&&(identical(other.myUser, myUser) || other.myUser == myUser));
}


@override
int get hashCode => Object.hash(runtimeType,myUser);

@override
String toString() {
  return 'AuthenticationState.authenticated(myUser: $myUser)';
}


}

/// @nodoc
abstract mixin class _$AuthenticatedCopyWith<$Res> implements $AuthenticationStateCopyWith<$Res> {
  factory _$AuthenticatedCopyWith(_Authenticated value, $Res Function(_Authenticated) _then) = __$AuthenticatedCopyWithImpl;
@useResult
$Res call({
 MyUser myUser
});


$MyUserCopyWith<$Res> get myUser;

}
/// @nodoc
class __$AuthenticatedCopyWithImpl<$Res>
    implements _$AuthenticatedCopyWith<$Res> {
  __$AuthenticatedCopyWithImpl(this._self, this._then);

  final _Authenticated _self;
  final $Res Function(_Authenticated) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? myUser = null,}) {
  return _then(_Authenticated(
null == myUser ? _self.myUser : myUser // ignore: cast_nullable_to_non_nullable
as MyUser,
  ));
}

/// Create a copy of AuthenticationState
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


class _Unauthenticated extends AuthenticationState {
  const _Unauthenticated(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.unauthenticated()';
}


}




/// @nodoc


class _Unknown extends AuthenticationState {
  const _Unknown(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unknown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.unknown()';
}


}




// dart format on
