import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:collection/collection.dart'; // For firstWhereOrNull
import 'package:table_calendar/table_calendar.dart';

import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:gulapedia/src/screens/journal/blocs/journal_bloc/journal_bloc.dart';

class CatatanBulananScreen extends StatefulWidget {
  const CatatanBulananScreen({super.key, required this.userId, this.date});
  final String userId;
  final DateTime? date;

  @override
  State<CatatanBulananScreen> createState() => _CatatanBulananScreenState();
}

class _CatatanBulananScreenState extends State<CatatanBulananScreen> {
  late JournalBloc _journalBloc;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.date ?? DateTime.now();
    _selectedDay = _focusedDay;
    _journalBloc = JournalBloc(FirebaseJournalRepo());
    _journalBloc.add(GetThisMonthJournal(widget.userId, _focusedDay));
  }

  @override
  void dispose() {
    _journalBloc.close();
    super.dispose();
  }

  // Helper function to compare dates without time components
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _journalBloc,
      child: LayoutAppbar(
        title: 'Rekap Bulanan',
        child: BlocBuilder<JournalBloc, JournalState>(
          builder: (context, state) {
            final List<Journal> monthlyJournals = state.periodJournals;

            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 65, 15, 0),
              child: Column(
                children: [
                  _buildCalendar(context, monthlyJournals: monthlyJournals),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEventsMarker(
    BuildContext context,
    DateTime date,
    List events,
    DateTime selectedDay,
  ) {
    return Icon(
      Icons.check_circle,
      size: 18,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildCalendar(
    BuildContext context, {
    required List<Journal> monthlyJournals,
  }) {
    return Card(
      child: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2050, 12, 31),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          context.pushReplacementNamed(
            RoutesName.catatanHarian,
            queryParameters: {'date': selectedDay.toIso8601String()},
          );
        },
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
          // When the month changes, fetch journals for the new month
          _journalBloc.add(GetThisMonthJournal(widget.userId, focusedDay));
        },
        // Event markers for days with meals
        eventLoader: (day) {
          final journal = monthlyJournals.firstWhereOrNull(
            (j) => isSameDay(j.date, day),
          );
          return journal != null && journal.hasMeals ? ['_dot'] : [];
        },
        calendarStyle: CalendarStyle(
          defaultTextStyle: const TextStyle(
            fontSize: 14.0,
          ), // Adjust font size to make dates smaller
          weekendTextStyle: const TextStyle(fontSize: 14.0),
          outsideTextStyle: TextStyle(
            fontSize: 14.0,
            color: Colors.grey.shade400,
          ),
          selectedDecoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.rectangle,
          ),
          todayDecoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.rectangle,
          ),

          selectedTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final String text;
            switch (day.weekday) {
              case DateTime.sunday:
                text = 'M';
                break;
              case DateTime.monday:
                text = 'S';
                break;
              case DateTime.tuesday:
                text = 'S';
                break;
              case DateTime.wednesday:
                text = 'R';
                break;
              case DateTime.thursday:
                text = 'K';
                break;
              case DateTime.friday:
                text = 'J';
                break;
              case DateTime.saturday:
                text = 'S';
                break;

              default:
                text = '';
            }
            return Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ), // Adjust color as needed
              ),
            );
          },
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Positioned(
                bottom: 2,
                child: Center(
                  child: _buildEventsMarker(
                    context,
                    date,
                    events,
                    _selectedDay,
                  ),
                ),
              );
            }
            return null;
          },
        ),
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
      ),
    );
  }
}
