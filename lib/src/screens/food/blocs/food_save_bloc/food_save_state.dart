// lib/src/screens/food/blocs/food_save_bloc/food_save_state.dart

part of 'food_save_bloc.dart';

// Define the statuses for FoodSave operations
enum FoodSaveStatus { initial, loading, loaded, failure, success }

// Main state class for the FoodSaveBloc
class FoodSaveState extends Equatable {
  final FoodSaveStatus status;
  final String? errorMessage;
  final List<Food> foods; // List to hold the current food items

  const FoodSaveState._({
    this.status = FoodSaveStatus.initial,
    this.errorMessage,
    this.foods = const [], // Initialize with an empty list
  });

  // Factory constructors for different states
  const FoodSaveState.initial() : this._();

  const FoodSaveState.loading({List<Food> foods = const []})
    : this._(status: FoodSaveStatus.loading, foods: foods);

  const FoodSaveState.loaded({required List<Food> foods})
    : this._(status: FoodSaveStatus.loaded, foods: foods);

  const FoodSaveState.failure(String errorMessage)
    : this._(status: FoodSaveStatus.failure, errorMessage: errorMessage);

  const FoodSaveState.success({List<Food> foods = const []})
    : this._(status: FoodSaveStatus.success, foods: foods);

  FoodSaveState copyWith({
    FoodSaveStatus? status,
    String? errorMessage,
    List<Food>? foods,
  }) {
    return FoodSaveState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      foods: foods ?? this.foods,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, foods];
}
