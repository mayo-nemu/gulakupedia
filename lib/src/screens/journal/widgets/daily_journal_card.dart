part of 'package:gulapedia/src/screens/journal/views/catatan_harian_screen.dart';

class DailyJournalCard extends StatelessWidget {
  const DailyJournalCard({
    super.key,
    required this.periodJournals, // Renamed from 'journals'
    required this.selectedDate,
    required this.sugarsConsumed,
    required this.sugarsGoal,
    this.onDayPressed,
  });

  final List<Journal> periodJournals; // Renamed
  final DateTime selectedDate;
  final double sugarsConsumed;
  final double sugarsGoal;
  final ValueChanged<DateTime>? onDayPressed;

  String _getShortDayName(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'S';
      case DateTime.tuesday:
        return 'S';
      case DateTime.wednesday:
        return 'R';
      case DateTime.thursday:
        return 'K';
      case DateTime.friday:
        return 'J';
      case DateTime.saturday:
        return 'S';
      case DateTime.sunday:
        return 'M';
      default:
        return '';
    }
  }

  // Helper function to compare dates without time components
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final startOfWeek = selectedDate.subtract(
      Duration(days: selectedDate.weekday - 1),
    );

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                final date = startOfWeek.add(Duration(days: index));
                final journalForDate = periodJournals.firstWhereOrNull(
                  (j) => isSameDay(j.date, date),
                );
                final hasMeals = journalForDate?.hasMeals ?? false;

                return Column(
                  children: [
                    const SizedBox(height: 13),
                    CircleAvatar(
                      radius: 21,
                      backgroundColor: isSameDay(date, selectedDate)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      child: IconButton(
                        onPressed: () => onDayPressed?.call(date),
                        icon: Center(
                          child: Icon(
                            Icons.check,
                            size: 21,
                            color: hasMeals
                                ? isSameDay(date, selectedDate)
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getShortDayName(date),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isSameDay(date, selectedDate)
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black54,
                        fontWeight: isSameDay(date, selectedDate)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 34),
            Text(
              'Gula',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 5,
                  child: LinearProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    value: sugarsConsumed / sugarsGoal,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${sugarsConsumed.toStringAsFixed(2)} /',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: ' ${sugarsGoal.toStringAsFixed(2)} g',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
