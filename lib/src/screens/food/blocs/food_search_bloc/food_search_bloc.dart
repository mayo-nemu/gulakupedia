// food_search_bloc.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:food_repository/food_repository.dart';

part 'food_search_event.dart';
part 'food_search_state.dart';

class FoodSearchBloc extends Bloc<FoodSearchEvent, FoodSearchState> {
  final FoodRepository foodRepository;

  FoodSearchBloc(this.foodRepository) : super(const FoodSearchState.initial()) {
    on<SearchByQuery>((event, emit) async {
      final List<Food> previousSelectedFoods = state.selectedFoods;

      emit(
        state.copyWith(
          status: FoodSearchStatus.loading,
          errorMessage: null,
          results: null, // Clear previous results when loading new ones
        ),
      );

      try {
        final results = await foodRepository.getFoodsByName(event.query ?? '');

        debugPrint(
          'Emitted FoodSearchloaded with selected: ${previousSelectedFoods.toString()}',
        );

        emit(
          state.copyWith(
            status: FoodSearchStatus.loaded,
            results: results,
            selectedFoods: previousSelectedFoods,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: FoodSearchStatus.failure,
            errorMessage: 'Search failed: ${e.toString()}',
            results: null,
          ),
        );
      }
    });

    on<SearchByBarcode>((event, emit) async {
      final List<Food> previousSelectedFoods = state.selectedFoods;

      emit(
        state.copyWith(
          status: FoodSearchStatus.loading,
          errorMessage: null,
          results: null, // Clear previous results when loading new ones
        ),
      );

      try {
        final results = await foodRepository.getFoodsByBarcode(
          event.barcode ?? '',
        );

        emit(
          state.copyWith(
            status: FoodSearchStatus.loaded,
            results: results,
            selectedFoods: previousSelectedFoods,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: FoodSearchStatus.failure,
            errorMessage: 'Search failed for barcode: ${e.toString()}',
            results: null,
          ),
        );
      }
    });

    on<ToggleFoodSelection>((event, emit) {
      final List<Food> updatedSelectedFoods = state.selectedFoods.toList();

      debugPrint('--- ToggleFoodSelection Debug ---');
      debugPrint(
        'Event Food: ${event.food.name} (ID: ${event.food.id}) Hash: ${event.food.hashCode}',
      );
      for (var sFood in updatedSelectedFoods) {
        debugPrint(
          'Selected Food: ${sFood.name} (ID: ${sFood.id}) Hash: ${sFood.hashCode}',
        );
      }

      if (updatedSelectedFoods.contains(event.food)) {
        debugPrint('Food found in selectedFoods, attempting to remove.');
        updatedSelectedFoods.remove(event.food);
      } else {
        debugPrint('Food NOT found in selectedFoods, attempting to add.');
        updatedSelectedFoods.add(event.food);
      }

      debugPrint(
        'Emitted FoodSearchState with selected: ${updatedSelectedFoods.toString()}',
      );
      emit(state.copyWith(selectedFoods: updatedSelectedFoods));
    });

    on<ClearSearch>((event, emit) {
      // Keep selected foods, but clear search results and reset status to initial
      emit(
        state.copyWith(
          status: FoodSearchStatus.initial,
          errorMessage: null,
          results: [], // Clear the displayed search results
          // selectedFoods will remain as is from the previous state
        ),
      );
    });
  }
}
