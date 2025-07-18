part of 'food_save_bloc.dart';

sealed class FoodSaveEvent extends Equatable {
  const FoodSaveEvent();

  @override
  List<Object> get props => [];
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
