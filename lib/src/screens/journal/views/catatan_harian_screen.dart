import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/routes/routes_name.dart';

import 'package:gulapedia/src/screens/journal/blocs/journal_bloc/journal_bloc.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:collection/collection.dart';
import 'package:user_repository/user_repository.dart';

part 'package:gulapedia/src/screens/journal/widgets/journal_info_card.dart';
part 'package:gulapedia/src/screens/journal/widgets/meal_info_card.dart';

class CatatanHarianScreen extends StatefulWidget {
  const CatatanHarianScreen({super.key, this.date});
  final DateTime? date;

  @override
  State<CatatanHarianScreen> createState() => _CatatanHarianScreenState();
}

class _CatatanHarianScreenState extends State<CatatanHarianScreen> {
  late MyUser _user;
  late JournalBloc _journalBloc;

  late DateTime _currentDisplayDate;

  @override
  void initState() {
    super.initState();
    _user = context.read<AuthenticationBloc>().state.user!;
    _journalBloc = context.read<JournalBloc>();
    _currentDisplayDate = widget.date ?? DateTime.now();
    _journalBloc.add(GetThisJournal(_user.userId, _currentDisplayDate));
  }

  @override
  void didUpdateWidget(covariant CatatanHarianScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only refresh if the date changes
    if (_currentDisplayDate != oldWidget.date) {
      _journalBloc.add(GetThisJournal(_user.userId, _currentDisplayDate));
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
    _journalBloc.add(GetThisJournal(_user.userId, selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    int weekNumber =
        ((_currentDisplayDate.day - 1) ~/ 7) +
        1; // This remains for weekly context

    final recSugars = 25.0; // Fixed recommended sugar intake

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
                  horizontal: 13,
                  vertical: 13,
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 13,
                        right: 13,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Atur Asupan \nSehat Favoritmu',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.1,
                                ),
                          ),
                          Container(
                            width: 55,
                            height: 55,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                              onPressed: () {
                                context.pushNamed(
                                  RoutesName.rekapBulanan,
                                  queryParameters: {
                                    'date': _currentDisplayDate
                                        .toIso8601String(),
                                  },
                                );
                              },
                              icon: const Icon(Icons.calendar_month),
                              iconSize: 34,
                              color: Color(0xFF1A998E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        top: 21,
                        left: 13,
                        right: 21,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Minggu $weekNumber',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.1,
                                ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 5),
                    JournalInfoCard(
                      periodJournals: periodJournals,
                      selectedDate: _currentDisplayDate,
                      sugarsConsumed: sugarsConsumedCurrentDay,
                      sugarsGoal: recSugars,
                      onDayPressed: _onDaySelectedInJournalInfoCard,
                    ),
                    const SizedBox(height: 34),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: Text(
                        'Nutrisi Harian',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    MealInfoCard(
                      journal: currentJournal,
                      meals: currentJournalMeals,
                      sugarsTotal: sugarsConsumedCurrentDay,
                      sugarsGoal: recSugars,
                    ),
                    // const Spacer(flex: 1),
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
