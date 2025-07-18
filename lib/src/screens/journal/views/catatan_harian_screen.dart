import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/routes/routes_name.dart';

import 'package:gulapedia/src/screens/journal/blocs/journal_bloc/journal_bloc.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:collection/collection.dart';

part 'package:gulapedia/src/screens/journal/widgets/journal_info_card.dart';
part 'package:gulapedia/src/screens/journal/widgets/meal_info_card.dart';

class CatatanHarianScreen extends StatefulWidget {
  const CatatanHarianScreen({super.key, required this.userId, this.date});
  final String userId;
  final DateTime? date;

  @override
  State<CatatanHarianScreen> createState() => _CatatanHarianScreenState();
}

class _CatatanHarianScreenState extends State<CatatanHarianScreen> {
  late JournalBloc _journalBloc;
  late DateTime _currentDisplayDate;

  @override
  void initState() {
    super.initState();
    _currentDisplayDate = widget.date ?? DateTime.now();
    _journalBloc = JournalBloc(FirebaseJournalRepo());
    _journalBloc.add(GetThisJournal(widget.userId, _currentDisplayDate));
  }

  @override
  void didUpdateWidget(covariant CatatanHarianScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only refresh if the date changes
    if (_currentDisplayDate != oldWidget.date) {
      _journalBloc.add(GetThisJournal(widget.userId, _currentDisplayDate));
    }
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

  void _onDaySelectedInJournalInfoCard(DateTime selectedDay) {
    setState(() {
      _currentDisplayDate = selectedDay;
    });
    _journalBloc.add(GetThisJournal(widget.userId, selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    int weekNumber =
        ((_currentDisplayDate.day - 1) ~/ 7) +
        1; // This remains for weekly context

    return BlocProvider.value(
      value: _journalBloc,
      child: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          if (state.status == JournalStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == JournalStatus.failure) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage ?? "An unknown error occurred."}',
              ),
            );
          } else if (state.status == JournalStatus.loaded) {
            final currentJournal = state.currentJournal;
            final periodJournals = state.periodJournals;
            final allPeriodMeals = state.allPeriodMeals;

            if (currentJournal == null) {
              return const Center(
                child: Text(
                  'Journal data not available for the selected date.',
                ),
              );
            }

            // Filter meals specific to the currentJournal using the new journalId property on Meal
            // This ensures we only show meals for the currently viewed day/journal
            final List<Meal> currentJournalMeals = allPeriodMeals
                .where((meal) => meal.journalId == currentJournal.id)
                .toList();

            // Calculate sugars consumed ONLY for the currentJournal's meals
            final double sugarsConsumedCurrentDay = currentJournalMeals.fold(
              0.0,
              (sum, meal) => sum + meal.totalSugarsGram,
            );

            // You can also calculate weekly/monthly sugars here from allPeriodMeals
            // if state.period tells you the context, but for this screen,
            // the daily sugar for currentJournal is most relevant.

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 56,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Atur asupan \n sehat favoritmu',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () {
                              context.pushNamed(
                                RoutesName.rekapBulanan,
                                queryParameters: {
                                  'date': _currentDisplayDate.toIso8601String(),
                                },
                              );
                            },
                            icon: const Icon(Icons.calendar_today_outlined),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Minggu $weekNumber',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextButton(
                          onPressed: () {
                            context.pushNamed(
                              RoutesName.rekapMingguan,
                              queryParameters: {
                                'date': _currentDisplayDate.toIso8601String(),
                              },
                            );
                          },
                          child: Text(
                            'Rincian',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    JournalInfoCard(
                      periodJournals: periodJournals,
                      selectedDate: _currentDisplayDate,
                      sugarsConsumed: sugarsConsumedCurrentDay,
                      sugarsGoal: currentJournal.sugarsGoal,
                      onDayPressed: _onDaySelectedInJournalInfoCard,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Nutrisi',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    MealInfoCard(
                      journal: currentJournal,
                      meals: currentJournalMeals,
                      sugarsTotal: sugarsConsumedCurrentDay,
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Select a date to view journal.'));
        },
      ),
    );
  }
}
