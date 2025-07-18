part of 'journal_bloc.dart';

sealed class JournalEvent extends Equatable {
  const JournalEvent();

  @override
  List<Object> get props => [];
}

class GetThisJournal extends JournalEvent {
  final String userId;
  final DateTime date;

  const GetThisJournal(this.userId, this.date);

  @override
  List<Object> get props => [userId, date];
}

class GetThisMonthJournal extends JournalEvent {
  final String userId;
  final DateTime date;

  const GetThisMonthJournal(this.userId, this.date);

  @override
  List<Object> get props => [userId, date];
}
