part of 'food_save_bloc.dart';

sealed class FoodSaveState extends Equatable {
  const FoodSaveState();

  @override
  List<Object> get props => [];
}

final class FoodSaveInitial extends FoodSaveState {}

final class FoodSaveFailure extends FoodSaveState {
  final String errorMessage;

  const FoodSaveFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class FoodSaveLoading extends FoodSaveState {}

final class FoodSaveSuccess extends FoodSaveState {}
