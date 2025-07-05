// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Food {

 String get id; String get name; double get servingWeightGram; double get calories100Gram; double get proteins100Gram; double get fats100Gram; double get sugars100Gram; double get quantity;
/// Create a copy of Food
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodCopyWith<Food> get copyWith => _$FoodCopyWithImpl<Food>(this as Food, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Food&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.servingWeightGram, servingWeightGram) || other.servingWeightGram == servingWeightGram)&&(identical(other.calories100Gram, calories100Gram) || other.calories100Gram == calories100Gram)&&(identical(other.proteins100Gram, proteins100Gram) || other.proteins100Gram == proteins100Gram)&&(identical(other.fats100Gram, fats100Gram) || other.fats100Gram == fats100Gram)&&(identical(other.sugars100Gram, sugars100Gram) || other.sugars100Gram == sugars100Gram)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,servingWeightGram,calories100Gram,proteins100Gram,fats100Gram,sugars100Gram,quantity);

@override
String toString() {
  return 'Food(id: $id, name: $name, servingWeightGram: $servingWeightGram, calories100Gram: $calories100Gram, proteins100Gram: $proteins100Gram, fats100Gram: $fats100Gram, sugars100Gram: $sugars100Gram, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $FoodCopyWith<$Res>  {
  factory $FoodCopyWith(Food value, $Res Function(Food) _then) = _$FoodCopyWithImpl;
@useResult
$Res call({
 String id, String name, double servingWeightGram, double calories100Gram, double proteins100Gram, double fats100Gram, double sugars100Gram, double quantity
});




}
/// @nodoc
class _$FoodCopyWithImpl<$Res>
    implements $FoodCopyWith<$Res> {
  _$FoodCopyWithImpl(this._self, this._then);

  final Food _self;
  final $Res Function(Food) _then;

/// Create a copy of Food
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? servingWeightGram = null,Object? calories100Gram = null,Object? proteins100Gram = null,Object? fats100Gram = null,Object? sugars100Gram = null,Object? quantity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,servingWeightGram: null == servingWeightGram ? _self.servingWeightGram : servingWeightGram // ignore: cast_nullable_to_non_nullable
as double,calories100Gram: null == calories100Gram ? _self.calories100Gram : calories100Gram // ignore: cast_nullable_to_non_nullable
as double,proteins100Gram: null == proteins100Gram ? _self.proteins100Gram : proteins100Gram // ignore: cast_nullable_to_non_nullable
as double,fats100Gram: null == fats100Gram ? _self.fats100Gram : fats100Gram // ignore: cast_nullable_to_non_nullable
as double,sugars100Gram: null == sugars100Gram ? _self.sugars100Gram : sugars100Gram // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _Food extends Food {
  const _Food({required this.id, required this.name, required this.servingWeightGram, required this.calories100Gram, required this.proteins100Gram, required this.fats100Gram, required this.sugars100Gram, required this.quantity}): super._();
  

@override final  String id;
@override final  String name;
@override final  double servingWeightGram;
@override final  double calories100Gram;
@override final  double proteins100Gram;
@override final  double fats100Gram;
@override final  double sugars100Gram;
@override final  double quantity;

/// Create a copy of Food
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodCopyWith<_Food> get copyWith => __$FoodCopyWithImpl<_Food>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Food&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.servingWeightGram, servingWeightGram) || other.servingWeightGram == servingWeightGram)&&(identical(other.calories100Gram, calories100Gram) || other.calories100Gram == calories100Gram)&&(identical(other.proteins100Gram, proteins100Gram) || other.proteins100Gram == proteins100Gram)&&(identical(other.fats100Gram, fats100Gram) || other.fats100Gram == fats100Gram)&&(identical(other.sugars100Gram, sugars100Gram) || other.sugars100Gram == sugars100Gram)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,servingWeightGram,calories100Gram,proteins100Gram,fats100Gram,sugars100Gram,quantity);

@override
String toString() {
  return 'Food(id: $id, name: $name, servingWeightGram: $servingWeightGram, calories100Gram: $calories100Gram, proteins100Gram: $proteins100Gram, fats100Gram: $fats100Gram, sugars100Gram: $sugars100Gram, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$FoodCopyWith<$Res> implements $FoodCopyWith<$Res> {
  factory _$FoodCopyWith(_Food value, $Res Function(_Food) _then) = __$FoodCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double servingWeightGram, double calories100Gram, double proteins100Gram, double fats100Gram, double sugars100Gram, double quantity
});




}
/// @nodoc
class __$FoodCopyWithImpl<$Res>
    implements _$FoodCopyWith<$Res> {
  __$FoodCopyWithImpl(this._self, this._then);

  final _Food _self;
  final $Res Function(_Food) _then;

/// Create a copy of Food
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? servingWeightGram = null,Object? calories100Gram = null,Object? proteins100Gram = null,Object? fats100Gram = null,Object? sugars100Gram = null,Object? quantity = null,}) {
  return _then(_Food(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,servingWeightGram: null == servingWeightGram ? _self.servingWeightGram : servingWeightGram // ignore: cast_nullable_to_non_nullable
as double,calories100Gram: null == calories100Gram ? _self.calories100Gram : calories100Gram // ignore: cast_nullable_to_non_nullable
as double,proteins100Gram: null == proteins100Gram ? _self.proteins100Gram : proteins100Gram // ignore: cast_nullable_to_non_nullable
as double,fats100Gram: null == fats100Gram ? _self.fats100Gram : fats100Gram // ignore: cast_nullable_to_non_nullable
as double,sugars100Gram: null == sugars100Gram ? _self.sugars100Gram : sugars100Gram // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
