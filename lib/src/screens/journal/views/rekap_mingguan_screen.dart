import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulapedia/src/screens/journal/widgets/weekly_journal_card.dart';
import 'package:gulapedia/src/utilities/daily_recommended_intake.dart';
import 'package:gulapedia/src/widgets/layout_appbar2.dart';
import 'package:user_repository/user_repository.dart';

import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/screens/journal/blocs/journal_bloc/journal_bloc.dart';
import 'package:gulapedia/src/screens/journal/models/weekly_journal.dart';

class RekapMingguanScreen extends StatefulWidget {
  const RekapMingguanScreen({super.key, this.date});
  final DateTime? date;

  @override
  State<RekapMingguanScreen> createState() => _RekapMingguanScreenState();
}

class _RekapMingguanScreenState extends State<RekapMingguanScreen> {
  late String _userId;
  late JournalBloc _journalBloc;

  void _showBatasKonsumsiInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Batas Konsumsi Mingguan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 13),
              Text(
                'Batas konsumsi dihitung berdasarkan rekomendasi harian '
                'yang dikalikan 7 hari.\n\n'
                '• Gula: Maksimal 10% dari total kalori\n'
                '• Kalori: Berdasarkan kebutuhan TDEE\n'
                '• Protein & Lemak: Berdasarkan distribusi makronutrien.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _userId = context.read<AuthenticationBloc>().state.user!.userId;

    _journalBloc = context.read<JournalBloc>();

    _journalBloc.add(
      GetThisMonthJournals(_userId, widget.date ?? DateTime.now()),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access recommended daily intake calculations based on the authenticated user.
    final MyUser user = context.read<AuthenticationBloc>().state.user!;
    final userData = DailyRecommendedIntake(
      dateOfBirth: user.birthday,
      gender: user.gender,
      weight: user.weight,
      height: user.height,
    );
    final tdee = userData.calculateTDEE(user.activities);
    final recCalories = userData.calculateRecommendedCalories(tdee, 'maintain');
    final macro = userData.calculateMacronutrients(recCalories);
    final recSugars = userData.calculateAddedSugarsLimit(recCalories);

    return LayoutAppbars2(
      title: 'Total Asupan Perminggu',
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
            final viewModel = WeeklyJournalsViewModel(
              monthlyJournals: state.periodJournals,
              monthlyMeals: state.allPeriodMeals,
            );
            final weeklyJournals = viewModel.getWeeklyJournals();

            if (weeklyJournals.isEmpty) {
              return const Center(
                child: Text('No weekly data available for this month.'),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 21, 13, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBatasKonsumsiInfo(context);
                        },
                        child: Row(
                          children: const [
                            Text(
                              'Batas Konsumsi',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.03,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.info, size: 28),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: weeklyJournals.length,
                    itemBuilder: (context, index) {
                      final journal = weeklyJournals[index];
                      final weekNumber = viewModel.getWeekNumber(
                        journal.startOfWeek,
                      );

                      return WeeklyJournalCard(
                        weekNumber: weekNumber,
                        journals: weeklyJournals[index],
                        recSugars: recSugars,
                        recCalories: recCalories,
                        macro: macro,
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
