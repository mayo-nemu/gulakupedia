// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyUser {

 String get userId; String get email; String get name; DateTime get birthday; String get gender; double get weight; double get height; String get activities; double get bloodSugars; bool get hasPremiumAccount;
/// Create a copy of MyUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyUserCopyWith<MyUser> get copyWith => _$MyUserCopyWithImpl<MyUser>(this as MyUser, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.height, height) || other.height == height)&&(identical(other.activities, activities) || other.activities == activities)&&(identical(other.bloodSugars, bloodSugars) || other.bloodSugars == bloodSugars)&&(identical(other.hasPremiumAccount, hasPremiumAccount) || other.hasPremiumAccount == hasPremiumAccount));
}


@override
int get hashCode => Object.hash(runtimeType,userId,email,name,birthday,gender,weight,height,activities,bloodSugars,hasPremiumAccount);

@override
String toString() {
  return 'MyUser(userId: $userId, email: $email, name: $name, birthday: $birthday, gender: $gender, weight: $weight, height: $height, activities: $activities, bloodSugars: $bloodSugars, hasPremiumAccount: $hasPremiumAccount)';
}


}

/// @nodoc
abstract mixin class $MyUserCopyWith<$Res>  {
  factory $MyUserCopyWith(MyUser value, $Res Function(MyUser) _then) = _$MyUserCopyWithImpl;
@useResult
$Res call({
 String userId, String email, String name, DateTime birthday, String gender, double weight, double height, String activities, double bloodSugars, bool hasPremiumAccount
});




}
/// @nodoc
class _$MyUserCopyWithImpl<$Res>
    implements $MyUserCopyWith<$Res> {
  _$MyUserCopyWithImpl(this._self, this._then);

  final MyUser _self;
  final $Res Function(MyUser) _then;

/// Create a copy of MyUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,Object? name = null,Object? birthday = null,Object? gender = null,Object? weight = null,Object? height = null,Object? activities = null,Object? bloodSugars = null,Object? hasPremiumAccount = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,birthday: null == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as String,bloodSugars: null == bloodSugars ? _self.bloodSugars : bloodSugars // ignore: cast_nullable_to_non_nullable
as double,hasPremiumAccount: null == hasPremiumAccount ? _self.hasPremiumAccount : hasPremiumAccount // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _MyUser extends MyUser {
  const _MyUser({required this.userId, required this.email, required this.name, required this.birthday, required this.gender, required this.weight, required this.height, required this.activities, required this.bloodSugars, required this.hasPremiumAccount}): super._();
  

@override final  String userId;
@override final  String email;
@override final  String name;
@override final  DateTime birthday;
@override final  String gender;
@override final  double weight;
@override final  double height;
@override final  String activities;
@override final  double bloodSugars;
@override final  bool hasPremiumAccount;

/// Create a copy of MyUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyUserCopyWith<_MyUser> get copyWith => __$MyUserCopyWithImpl<_MyUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.height, height) || other.height == height)&&(identical(other.activities, activities) || other.activities == activities)&&(identical(other.bloodSugars, bloodSugars) || other.bloodSugars == bloodSugars)&&(identical(other.hasPremiumAccount, hasPremiumAccount) || other.hasPremiumAccount == hasPremiumAccount));
}


@override
int get hashCode => Object.hash(runtimeType,userId,email,name,birthday,gender,weight,height,activities,bloodSugars,hasPremiumAccount);

@override
String toString() {
  return 'MyUser(userId: $userId, email: $email, name: $name, birthday: $birthday, gender: $gender, weight: $weight, height: $height, activities: $activities, bloodSugars: $bloodSugars, hasPremiumAccount: $hasPremiumAccount)';
}


}

/// @nodoc
abstract mixin class _$MyUserCopyWith<$Res> implements $MyUserCopyWith<$Res> {
  factory _$MyUserCopyWith(_MyUser value, $Res Function(_MyUser) _then) = __$MyUserCopyWithImpl;
@override @useResult
$Res call({
 String userId, String email, String name, DateTime birthday, String gender, double weight, double height, String activities, double bloodSugars, bool hasPremiumAccount
});




}
/// @nodoc
class __$MyUserCopyWithImpl<$Res>
    implements _$MyUserCopyWith<$Res> {
  __$MyUserCopyWithImpl(this._self, this._then);

  final _MyUser _self;
  final $Res Function(_MyUser) _then;

/// Create a copy of MyUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,Object? name = null,Object? birthday = null,Object? gender = null,Object? weight = null,Object? height = null,Object? activities = null,Object? bloodSugars = null,Object? hasPremiumAccount = null,}) {
  return _then(_MyUser(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,birthday: null == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as String,bloodSugars: null == bloodSugars ? _self.bloodSugars : bloodSugars // ignore: cast_nullable_to_non_nullable
as double,hasPremiumAccount: null == hasPremiumAccount ? _self.hasPremiumAccount : hasPremiumAccount // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
