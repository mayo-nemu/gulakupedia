part of 'journal_bloc.dart';

enum JournalStatus { initial, loading, loaded, failure }

// New enum to distinguish between weekly and monthly data
enum JournalPeriod { week, month }

// Single JournalState class
class JournalState extends Equatable {
  final JournalStatus status;
  final String? errorMessage;
  final Journal? currentJournal;
  final List<Journal> periodJournals;
  final List<Meal> allPeriodMeals;
  final JournalPeriod period;

  const JournalState._({
    this.status = JournalStatus.initial,
    this.errorMessage,
    this.currentJournal,
    this.periodJournals = const [],
    this.allPeriodMeals = const [],
    this.period = JournalPeriod.week,
  });

  const JournalState.initial() : this._();

  const JournalState.loading({
    Journal? currentJournal,
    List<Journal> periodJournals = const [],
    List<Meal> allPeriodMeals = const [],
    JournalPeriod period = JournalPeriod.week,
  }) : this._(
         status: JournalStatus.loading,
         currentJournal: currentJournal,
         periodJournals: periodJournals,
         allPeriodMeals: allPeriodMeals,
         period: period,
       );

  const JournalState.loaded({
    required Journal currentJournal,
    required List<Journal> periodJournals,
    required List<Meal> allPeriodMeals,
    required JournalPeriod period,
  }) : this._(
         status: JournalStatus.loaded,
         currentJournal: currentJournal,
         periodJournals: periodJournals,
         allPeriodMeals: allPeriodMeals,
         period: period,
       );

  const JournalState.failure(String errorMessage)
    : this._(status: JournalStatus.failure, errorMessage: errorMessage);

  JournalState copyWith({
    JournalStatus? status,
    String? errorMessage,
    Journal? currentJournal,
    List<Journal>? periodJournals,
    List<Meal>? allPeriodMeals,
    JournalPeriod? period,
  }) {
    return JournalState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentJournal: currentJournal ?? this.currentJournal,
      periodJournals: periodJournals ?? this.periodJournals,
      allPeriodMeals: allPeriodMeals ?? this.allPeriodMeals,
      period: period ?? this.period,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    currentJournal,
    periodJournals,
    allPeriodMeals,
    period,
  ];
}
