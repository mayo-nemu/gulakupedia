// food_search_state.dart
part of 'food_search_bloc.dart';

// Define the enumeration for different search statuses
enum FoodSearchStatus { initial, loading, loaded, failure }

class FoodSearchState extends Equatable {
  final FoodSearchStatus status;
  final String? errorMessage;
  final List<Food>? results;
  final List<Food> selectedFoods;

  const FoodSearchState._({
    this.status = FoodSearchStatus.initial,
    this.errorMessage,
    this.results,
    this.selectedFoods = const [],
  });

  const FoodSearchState.initial() : this._();
  const FoodSearchState.loading() : this._(status: FoodSearchStatus.loading);
  const FoodSearchState.loaded({
    List<Food>? results,
    List<Food> selectedFoods = const [],
  }) : this._(
         status: FoodSearchStatus.loaded,
         results: results,
         selectedFoods: selectedFoods,
       );
  const FoodSearchState.failure(String errorMessage)
    : this._(status: FoodSearchStatus.failure, errorMessage: errorMessage);

  FoodSearchState copyWith({
    FoodSearchStatus? status,
    String? errorMessage,
    List<Food>? results,
    List<Food>? selectedFoods,
  }) {
    return FoodSearchState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      results: results ?? this.results,
      selectedFoods: selectedFoods ?? this.selectedFoods,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, results, selectedFoods];
}
