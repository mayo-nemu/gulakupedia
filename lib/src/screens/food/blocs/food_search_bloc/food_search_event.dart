part of 'food_search_bloc.dart';

sealed class FoodSearchEvent extends Equatable {
  const FoodSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchByQuery extends FoodSearchEvent {
  final String? query;

  const SearchByQuery(this.query);

  @override
  List<Object> get props => [];
}

class SearchByBarcode extends FoodSearchEvent {
  final String? barcode;

  const SearchByBarcode(this.barcode);

  @override
  List<Object> get props => [];
}

class ToggleFoodSelection extends FoodSearchEvent {
  final Food food;

  const ToggleFoodSelection(this.food);

  @override
  List<Object> get props => [];
}

class ClearSearch extends FoodSearchEvent {}
