part of 'meal_bloc.dart';

sealed class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object> get props => [];
}

class GetThisMeal extends MealEvent {
  final String userId;
  final String journalId;
  final String mealName;

  const GetThisMeal(this.userId, this.journalId, this.mealName);

  @override
  List<Object> get props => [userId, journalId, mealName];
}
