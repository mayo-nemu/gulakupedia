// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Meal {

 String get id; String? get journalId; String get name; double get totalCaloriesGram; double get totalProteinGram; double get totalFatGram; double get totalSugarsGram; bool get hasFoods;
/// Create a copy of Meal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealCopyWith<Meal> get copyWith => _$MealCopyWithImpl<Meal>(this as Meal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Meal&&(identical(other.id, id) || other.id == id)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalCaloriesGram, totalCaloriesGram) || other.totalCaloriesGram == totalCaloriesGram)&&(identical(other.totalProteinGram, totalProteinGram) || other.totalProteinGram == totalProteinGram)&&(identical(other.totalFatGram, totalFatGram) || other.totalFatGram == totalFatGram)&&(identical(other.totalSugarsGram, totalSugarsGram) || other.totalSugarsGram == totalSugarsGram)&&(identical(other.hasFoods, hasFoods) || other.hasFoods == hasFoods));
}


@override
int get hashCode => Object.hash(runtimeType,id,journalId,name,totalCaloriesGram,totalProteinGram,totalFatGram,totalSugarsGram,hasFoods);

@override
String toString() {
  return 'Meal(id: $id, journalId: $journalId, name: $name, totalCaloriesGram: $totalCaloriesGram, totalProteinGram: $totalProteinGram, totalFatGram: $totalFatGram, totalSugarsGram: $totalSugarsGram, hasFoods: $hasFoods)';
}


}

/// @nodoc
abstract mixin class $MealCopyWith<$Res>  {
  factory $MealCopyWith(Meal value, $Res Function(Meal) _then) = _$MealCopyWithImpl;
@useResult
$Res call({
 String id, String? journalId, String name, double totalCaloriesGram, double totalProteinGram, double totalFatGram, double totalSugarsGram, bool hasFoods
});




}
/// @nodoc
class _$MealCopyWithImpl<$Res>
    implements $MealCopyWith<$Res> {
  _$MealCopyWithImpl(this._self, this._then);

  final Meal _self;
  final $Res Function(Meal) _then;

/// Create a copy of Meal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? journalId = freezed,Object? name = null,Object? totalCaloriesGram = null,Object? totalProteinGram = null,Object? totalFatGram = null,Object? totalSugarsGram = null,Object? hasFoods = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalCaloriesGram: null == totalCaloriesGram ? _self.totalCaloriesGram : totalCaloriesGram // ignore: cast_nullable_to_non_nullable
as double,totalProteinGram: null == totalProteinGram ? _self.totalProteinGram : totalProteinGram // ignore: cast_nullable_to_non_nullable
as double,totalFatGram: null == totalFatGram ? _self.totalFatGram : totalFatGram // ignore: cast_nullable_to_non_nullable
as double,totalSugarsGram: null == totalSugarsGram ? _self.totalSugarsGram : totalSugarsGram // ignore: cast_nullable_to_non_nullable
as double,hasFoods: null == hasFoods ? _self.hasFoods : hasFoods // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _Meal extends Meal {
  const _Meal({required this.id, this.journalId, required this.name, required this.totalCaloriesGram, required this.totalProteinGram, required this.totalFatGram, required this.totalSugarsGram, required this.hasFoods}): super._();
  

@override final  String id;
@override final  String? journalId;
@override final  String name;
@override final  double totalCaloriesGram;
@override final  double totalProteinGram;
@override final  double totalFatGram;
@override final  double totalSugarsGram;
@override final  bool hasFoods;

/// Create a copy of Meal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealCopyWith<_Meal> get copyWith => __$MealCopyWithImpl<_Meal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Meal&&(identical(other.id, id) || other.id == id)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalCaloriesGram, totalCaloriesGram) || other.totalCaloriesGram == totalCaloriesGram)&&(identical(other.totalProteinGram, totalProteinGram) || other.totalProteinGram == totalProteinGram)&&(identical(other.totalFatGram, totalFatGram) || other.totalFatGram == totalFatGram)&&(identical(other.totalSugarsGram, totalSugarsGram) || other.totalSugarsGram == totalSugarsGram)&&(identical(other.hasFoods, hasFoods) || other.hasFoods == hasFoods));
}


@override
int get hashCode => Object.hash(runtimeType,id,journalId,name,totalCaloriesGram,totalProteinGram,totalFatGram,totalSugarsGram,hasFoods);

@override
String toString() {
  return 'Meal(id: $id, journalId: $journalId, name: $name, totalCaloriesGram: $totalCaloriesGram, totalProteinGram: $totalProteinGram, totalFatGram: $totalFatGram, totalSugarsGram: $totalSugarsGram, hasFoods: $hasFoods)';
}


}

/// @nodoc
abstract mixin class _$MealCopyWith<$Res> implements $MealCopyWith<$Res> {
  factory _$MealCopyWith(_Meal value, $Res Function(_Meal) _then) = __$MealCopyWithImpl;
@override @useResult
$Res call({
 String id, String? journalId, String name, double totalCaloriesGram, double totalProteinGram, double totalFatGram, double totalSugarsGram, bool hasFoods
});




}
/// @nodoc
class __$MealCopyWithImpl<$Res>
    implements _$MealCopyWith<$Res> {
  __$MealCopyWithImpl(this._self, this._then);

  final _Meal _self;
  final $Res Function(_Meal) _then;

/// Create a copy of Meal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? journalId = freezed,Object? name = null,Object? totalCaloriesGram = null,Object? totalProteinGram = null,Object? totalFatGram = null,Object? totalSugarsGram = null,Object? hasFoods = null,}) {
  return _then(_Meal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalCaloriesGram: null == totalCaloriesGram ? _self.totalCaloriesGram : totalCaloriesGram // ignore: cast_nullable_to_non_nullable
as double,totalProteinGram: null == totalProteinGram ? _self.totalProteinGram : totalProteinGram // ignore: cast_nullable_to_non_nullable
as double,totalFatGram: null == totalFatGram ? _self.totalFatGram : totalFatGram // ignore: cast_nullable_to_non_nullable
as double,totalSugarsGram: null == totalSugarsGram ? _self.totalSugarsGram : totalSugarsGram // ignore: cast_nullable_to_non_nullable
as double,hasFoods: null == hasFoods ? _self.hasFoods : hasFoods // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
