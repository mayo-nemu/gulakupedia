import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:collection/collection.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final JournalRepository journalRepository;

  JournalBloc(this.journalRepository) : super(const JournalState.initial()) {
    on<GetThisJournal>((event, emit) async {
      // Emit loading state, preserving existing data if available
      emit(state.copyWith(status: JournalStatus.loading));

      try {
        // 1. Get journals for the week
        List<Journal> journals = await journalRepository.getThisWeekJournals(
          event.userId,
          event.date,
        );

        // 2. Try to find the current journal in the fetched list
        // Using firstWhereOrNull for a cleaner null-safe approach
        Journal? currentJournal = journals.firstWhereOrNull(
          (journal) => isSameDay(journal.date, event.date),
        );

        // 3. If currentJournal is null, fetch/create it specifically
        if (currentJournal == null) {
          currentJournal = await journalRepository.getThisJournal(
            event.userId,
            event.date,
          );
          // If a new journal was created and it's not already in the weekly list, add it.
          if (!journals.any((j) => isSameDay(j.date, currentJournal!.date))) {
            journals.add(currentJournal);
            journals.sort(
              (a, b) => a.date.compareTo(b.date),
            ); // Keep sorted by date
          }
        }

        // 4. Get ALL meals for the entire week
        final List<Meal> allWeeklyMeals = await journalRepository
            .getThisWeekAllMeals(event.userId, event.date);

        // 5. Emit success state with all the data for the week
        emit(
          JournalState.loaded(
            currentJournal: currentJournal,
            periodJournals: journals, // Now periodJournals for weekly
            allPeriodMeals: allWeeklyMeals, // Now allPeriodMeals for weekly
            period: JournalPeriod.week, // Indicate that this is weekly data
          ),
        );
      } catch (e) {
        emit(
          JournalState.failure(
            'Failed to retrieve weekly journal data: ${e.toString()}',
          ),
        );
      }
    });

    // New event handler for GetThisMonthJournal
    on<GetThisMonthJournals>((event, emit) async {
      emit(state.copyWith(status: JournalStatus.loading));

      try {
        // 1. Get all journals for the month
        final List<Journal> monthlyJournals = await journalRepository
            .getThisMonthJournals(event.userId, event.date);

        // 2. Get all meals for the entire month
        final List<Meal> allMonthlyMeals = await journalRepository
            .getThisMonthAllMeals(event.userId, event.date);

        // For monthly view, currentJournal might not be strictly needed or
        // it could default to the first day of the month's journal if available,
        // or just be null if not focusing on a single day.
        // For simplicity, let's set currentJournal to null or the first available journal of the month if needed.
        final Journal? currentMonthJournal = monthlyJournals.firstWhereOrNull(
          (journal) => isSameDay(journal.date, event.date),
        );

        // 3. Emit success state with all the data for the month
        emit(
          JournalState.loaded(
            currentJournal:
                currentMonthJournal ??
                Journal.empty().copyWith(
                  date: event.date,
                ), // Provide a default if null
            periodJournals: monthlyJournals, // periodJournals for monthly
            allPeriodMeals: allMonthlyMeals, // allPeriodMeals for monthly
            period: JournalPeriod.month, // Indicate that this is monthly data
          ),
        );
      } catch (e) {
        emit(
          JournalState.failure(
            'Failed to retrieve monthly journal data: ${e.toString()}',
          ),
        );
      }
    });
  }

  // Helper function to compare dates without time components
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
