import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_repository/journal_repository.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final JournalRepository journalRepository;

  MealBloc(this.journalRepository) : super(MealInitial()) {
    on<GetThisMeal>((event, emit) async {
      emit(MealLoading());
      try {
        final currentMeal = await journalRepository.getThisMeal(
          event.userId,
          event.journalId,
          event.mealName,
        );
        final foods = await journalRepository.getThisMealFoods(
          event.userId,
          event.journalId,
          currentMeal.id,
        );
        emit(MealSuccess(currentMeal, foods));
      } catch (e) {
        emit(MealFailure('Failed to retrieve data: ${e.toString()}'));
      }
    });
  }
}
