// lib/src/screens/food/blocs/food_save_bloc/food_save_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_repository/journal_repository.dart';

part 'food_save_event.dart';
part 'food_save_state.dart';

class FoodSaveBloc extends Bloc<FoodSaveEvent, FoodSaveState> {
  final JournalRepository _journalRepository;

  // Initialize with the new FoodSaveState.initial()
  FoodSaveBloc(this._journalRepository) : super(const FoodSaveState.initial()) {
    // Handler for updating food quantity
    on<FoodQuantityUpdated>((event, emit) {
      // Create a mutable copy of the current foods from the state
      final List<Food> currentFoods = List.from(state.foods);
      final int index = currentFoods.indexWhere(
        (food) => food.id == event.updatedFood.id,
      );

      if (index != -1) {
        currentFoods[index] = event.updatedFood;
      } else {
        currentFoods.add(event.updatedFood);
      }

      emit(state.copyWith(foods: currentFoods, status: FoodSaveStatus.loaded));
    });

    on<AddFoodtoMenu>((event, emit) async {
      try {
        emit(FoodSaveState.loading(foods: state.foods));
        await _journalRepository.addFoodToMeal(
          event.userId,
          event.journalId,
          event.mealId,
          event.foods,
        );

        emit(FoodSaveState.success(foods: state.foods));
      } catch (e) {
        emit(
          FoodSaveState.failure('Failed to add food to meal: ${e.toString()}'),
        );
      }
    });
  }
}
