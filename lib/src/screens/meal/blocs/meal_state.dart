part of 'meal_bloc.dart';

sealed class MealState extends Equatable {
  const MealState();

  @override
  List<Object> get props => [];
}

final class MealInitial extends MealState {}

final class MealFailure extends MealState {
  final String errorMessage;

  const MealFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class MealLoading extends MealState {}

final class MealSuccess extends MealState {
  final Meal meal;
  final List<Food> foods;

  const MealSuccess(this.meal, this.foods);

  @override
  List<Object> get props => [meal, foods];
}
