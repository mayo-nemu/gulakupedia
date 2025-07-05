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

 String get id; String get name; double get totalCaloriesGram; double get totalProteinsGram; double get totalFatsGram; double get totalSugarsGram; List<Food> get foods;
/// Create a copy of Meal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealCopyWith<Meal> get copyWith => _$MealCopyWithImpl<Meal>(this as Meal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Meal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalCaloriesGram, totalCaloriesGram) || other.totalCaloriesGram == totalCaloriesGram)&&(identical(other.totalProteinsGram, totalProteinsGram) || other.totalProteinsGram == totalProteinsGram)&&(identical(other.totalFatsGram, totalFatsGram) || other.totalFatsGram == totalFatsGram)&&(identical(other.totalSugarsGram, totalSugarsGram) || other.totalSugarsGram == totalSugarsGram)&&const DeepCollectionEquality().equals(other.foods, foods));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,totalCaloriesGram,totalProteinsGram,totalFatsGram,totalSugarsGram,const DeepCollectionEquality().hash(foods));

@override
String toString() {
  return 'Meal(id: $id, name: $name, totalCaloriesGram: $totalCaloriesGram, totalProteinsGram: $totalProteinsGram, totalFatsGram: $totalFatsGram, totalSugarsGram: $totalSugarsGram, foods: $foods)';
}


}

/// @nodoc
abstract mixin class $MealCopyWith<$Res>  {
  factory $MealCopyWith(Meal value, $Res Function(Meal) _then) = _$MealCopyWithImpl;
@useResult
$Res call({
 String id, String name, double totalCaloriesGram, double totalProteinsGram, double totalFatsGram, double totalSugarsGram, List<Food> foods
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? totalCaloriesGram = null,Object? totalProteinsGram = null,Object? totalFatsGram = null,Object? totalSugarsGram = null,Object? foods = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalCaloriesGram: null == totalCaloriesGram ? _self.totalCaloriesGram : totalCaloriesGram // ignore: cast_nullable_to_non_nullable
as double,totalProteinsGram: null == totalProteinsGram ? _self.totalProteinsGram : totalProteinsGram // ignore: cast_nullable_to_non_nullable
as double,totalFatsGram: null == totalFatsGram ? _self.totalFatsGram : totalFatsGram // ignore: cast_nullable_to_non_nullable
as double,totalSugarsGram: null == totalSugarsGram ? _self.totalSugarsGram : totalSugarsGram // ignore: cast_nullable_to_non_nullable
as double,foods: null == foods ? _self.foods : foods // ignore: cast_nullable_to_non_nullable
as List<Food>,
  ));
}

}


/// @nodoc


class _Meal extends Meal {
  const _Meal({required this.id, required this.name, required this.totalCaloriesGram, required this.totalProteinsGram, required this.totalFatsGram, required this.totalSugarsGram, required final  List<Food> foods}): _foods = foods,super._();
  

@override final  String id;
@override final  String name;
@override final  double totalCaloriesGram;
@override final  double totalProteinsGram;
@override final  double totalFatsGram;
@override final  double totalSugarsGram;
 final  List<Food> _foods;
@override List<Food> get foods {
  if (_foods is EqualUnmodifiableListView) return _foods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_foods);
}


/// Create a copy of Meal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealCopyWith<_Meal> get copyWith => __$MealCopyWithImpl<_Meal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Meal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalCaloriesGram, totalCaloriesGram) || other.totalCaloriesGram == totalCaloriesGram)&&(identical(other.totalProteinsGram, totalProteinsGram) || other.totalProteinsGram == totalProteinsGram)&&(identical(other.totalFatsGram, totalFatsGram) || other.totalFatsGram == totalFatsGram)&&(identical(other.totalSugarsGram, totalSugarsGram) || other.totalSugarsGram == totalSugarsGram)&&const DeepCollectionEquality().equals(other._foods, _foods));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,totalCaloriesGram,totalProteinsGram,totalFatsGram,totalSugarsGram,const DeepCollectionEquality().hash(_foods));

@override
String toString() {
  return 'Meal(id: $id, name: $name, totalCaloriesGram: $totalCaloriesGram, totalProteinsGram: $totalProteinsGram, totalFatsGram: $totalFatsGram, totalSugarsGram: $totalSugarsGram, foods: $foods)';
}


}

/// @nodoc
abstract mixin class _$MealCopyWith<$Res> implements $MealCopyWith<$Res> {
  factory _$MealCopyWith(_Meal value, $Res Function(_Meal) _then) = __$MealCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double totalCaloriesGram, double totalProteinsGram, double totalFatsGram, double totalSugarsGram, List<Food> foods
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? totalCaloriesGram = null,Object? totalProteinsGram = null,Object? totalFatsGram = null,Object? totalSugarsGram = null,Object? foods = null,}) {
  return _then(_Meal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalCaloriesGram: null == totalCaloriesGram ? _self.totalCaloriesGram : totalCaloriesGram // ignore: cast_nullable_to_non_nullable
as double,totalProteinsGram: null == totalProteinsGram ? _self.totalProteinsGram : totalProteinsGram // ignore: cast_nullable_to_non_nullable
as double,totalFatsGram: null == totalFatsGram ? _self.totalFatsGram : totalFatsGram // ignore: cast_nullable_to_non_nullable
as double,totalSugarsGram: null == totalSugarsGram ? _self.totalSugarsGram : totalSugarsGram // ignore: cast_nullable_to_non_nullable
as double,foods: null == foods ? _self._foods : foods // ignore: cast_nullable_to_non_nullable
as List<Food>,
  ));
}


}

// dart format on
