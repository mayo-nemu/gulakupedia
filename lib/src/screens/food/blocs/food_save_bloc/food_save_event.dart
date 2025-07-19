// lib/src/screens/food/blocs/food_save_bloc/food_save_event.dart

part of 'food_save_bloc.dart';

sealed class FoodSaveEvent extends Equatable {
  const FoodSaveEvent();

  @override
  List<Object> get props => [];
}

class FoodQuantityUpdated extends FoodSaveEvent {
  final Food updatedFood;

  const FoodQuantityUpdated({required this.updatedFood});

  @override
  List<Object> get props => [updatedFood];
}

class AddFoodtoMenu extends FoodSaveEvent {
  final String userId;
  final String journalId;
  final String mealId;
  final List<Food> foods;

  const AddFoodtoMenu(this.foods, this.userId, this.journalId, this.mealId);

  @override
  List<Object> get props => [userId, journalId, mealId];
}
