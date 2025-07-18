import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_repository/journal_repository.dart';

part 'food_save_event.dart';
part 'food_save_state.dart';

class FoodSaveBloc extends Bloc<FoodSaveEvent, FoodSaveState> {
  final JournalRepository _journalRepository;
  FoodSaveBloc(this._journalRepository) : super(FoodSaveInitial()) {
    on<AddFoodtoMenu>((event, emit) async {
      emit(FoodSaveLoading());
      try {
        await _journalRepository.addFoodToMeal(
          event.userId,
          event.journalId,
          event.mealId,
          event.foods,
        );

        emit(FoodSaveSuccess());
      } catch (e) {
        emit(FoodSaveFailure('Search failed: ${e.toString()}'));
      }
    });
  }
}
