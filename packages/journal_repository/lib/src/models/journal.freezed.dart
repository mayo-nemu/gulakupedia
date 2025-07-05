// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Journal {

 String get id; DateTime get date; double get sugarsGoal; List<Meal> get meals;
/// Create a copy of Journal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalCopyWith<Journal> get copyWith => _$JournalCopyWithImpl<Journal>(this as Journal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Journal&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.sugarsGoal, sugarsGoal) || other.sugarsGoal == sugarsGoal)&&const DeepCollectionEquality().equals(other.meals, meals));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,sugarsGoal,const DeepCollectionEquality().hash(meals));

@override
String toString() {
  return 'Journal(id: $id, date: $date, sugarsGoal: $sugarsGoal, meals: $meals)';
}


}

/// @nodoc
abstract mixin class $JournalCopyWith<$Res>  {
  factory $JournalCopyWith(Journal value, $Res Function(Journal) _then) = _$JournalCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, double sugarsGoal, List<Meal> meals
});




}
/// @nodoc
class _$JournalCopyWithImpl<$Res>
    implements $JournalCopyWith<$Res> {
  _$JournalCopyWithImpl(this._self, this._then);

  final Journal _self;
  final $Res Function(Journal) _then;

/// Create a copy of Journal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? sugarsGoal = null,Object? meals = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,sugarsGoal: null == sugarsGoal ? _self.sugarsGoal : sugarsGoal // ignore: cast_nullable_to_non_nullable
as double,meals: null == meals ? _self.meals : meals // ignore: cast_nullable_to_non_nullable
as List<Meal>,
  ));
}

}


/// @nodoc


class _Journal extends Journal {
  const _Journal({required this.id, required this.date, required this.sugarsGoal, required final  List<Meal> meals}): _meals = meals,super._();
  

@override final  String id;
@override final  DateTime date;
@override final  double sugarsGoal;
 final  List<Meal> _meals;
@override List<Meal> get meals {
  if (_meals is EqualUnmodifiableListView) return _meals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meals);
}


/// Create a copy of Journal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalCopyWith<_Journal> get copyWith => __$JournalCopyWithImpl<_Journal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Journal&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.sugarsGoal, sugarsGoal) || other.sugarsGoal == sugarsGoal)&&const DeepCollectionEquality().equals(other._meals, _meals));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,sugarsGoal,const DeepCollectionEquality().hash(_meals));

@override
String toString() {
  return 'Journal(id: $id, date: $date, sugarsGoal: $sugarsGoal, meals: $meals)';
}


}

/// @nodoc
abstract mixin class _$JournalCopyWith<$Res> implements $JournalCopyWith<$Res> {
  factory _$JournalCopyWith(_Journal value, $Res Function(_Journal) _then) = __$JournalCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, double sugarsGoal, List<Meal> meals
});




}
/// @nodoc
class __$JournalCopyWithImpl<$Res>
    implements _$JournalCopyWith<$Res> {
  __$JournalCopyWithImpl(this._self, this._then);

  final _Journal _self;
  final $Res Function(_Journal) _then;

/// Create a copy of Journal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? sugarsGoal = null,Object? meals = null,}) {
  return _then(_Journal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,sugarsGoal: null == sugarsGoal ? _self.sugarsGoal : sugarsGoal // ignore: cast_nullable_to_non_nullable
as double,meals: null == meals ? _self._meals : meals // ignore: cast_nullable_to_non_nullable
as List<Meal>,
  ));
}


}

// dart format on
