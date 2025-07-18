part of 'package:gulapedia/src/screens/journal/views/catatan_harian_screen.dart';

class MealInfoCard extends StatelessWidget {
  const MealInfoCard({
    super.key,
    required this.journal,
    required this.meals,
    this.sugarsTotal = 0,
  });
  final Journal journal;
  final double? sugarsTotal;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Meal breakfast =
        meals.firstWhereOrNull((meal) => meal.name == 'Asupan Pagi') ??
        Meal.empty().copyWith(name: 'Asupan Pagi', journalId: journal.id);

    Meal lunch =
        meals.firstWhereOrNull((meal) => meal.name == 'Asupan Siang') ??
        Meal.empty().copyWith(name: 'Asupan Siang', journalId: journal.id);

    Meal dinner =
        meals.firstWhereOrNull((meal) => meal.name == 'Asupan Malam') ??
        Meal.empty().copyWith(name: 'Asupan Malam', journalId: journal.id);

    Meal snack =
        meals.firstWhereOrNull((meal) => meal.name == 'Cemilan') ??
        Meal.empty().copyWith(name: 'Cemilan', journalId: journal.id);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            MealItem(
              icon: 'assets/icons/noto_bread.png',
              onPressed: () {
                context.pushNamed(
                  RoutesName.asupan,
                  pathParameters: {'journalId': journal.id},
                  queryParameters: {'mealName': breakfast.name},
                  extra: {
                    'sugarsGoal': journal.sugarsGoal,
                    'sugarsTotal': sugarsTotal,
                  },
                );
              },
              meal: breakfast,
            ),
            Divider(color: Colors.grey),
            MealItem(
              icon: 'assets/icons/noto_pot-of-food.png',
              onPressed: () {
                context.pushNamed(
                  RoutesName.asupan,
                  pathParameters: {'journalId': journal.id},
                  queryParameters: {'mealName': lunch.name},
                  extra: {
                    'sugarsGoal': journal.sugarsGoal,
                    'sugarsTotal': sugarsTotal,
                  },
                );
              },
              meal: lunch,
            ),
            Divider(color: Colors.grey),
            MealItem(
              icon: 'assets/icons/noto_green-salad.png',
              onPressed: () {
                context.pushNamed(
                  RoutesName.asupan,
                  pathParameters: {'journalId': journal.id},
                  queryParameters: {'mealName': dinner.name},
                  extra: {
                    'sugarsGoal': journal.sugarsGoal,
                    'sugarsTotal': sugarsTotal,
                  },
                );
              },
              meal: dinner,
            ),
            Divider(color: Colors.grey),
            MealItem(
              icon: 'assets/icons/noto_kiwi-fruit.png',
              onPressed: () {
                context.pushNamed(
                  RoutesName.asupan,
                  pathParameters: {'journalId': journal.id},
                  queryParameters: {'mealName': snack.name},
                  extra: {
                    'sugarsGoal': journal.sugarsGoal,
                    'sugarsTotal': sugarsTotal,
                  },
                );
              },
              meal: snack,
            ),
          ],
        ),
      ),
    );
  }
}

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.meal,
  });
  final String icon;
  final VoidCallback onPressed;
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 56,
        width: 56,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: 48,
                width: 48,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  value: meal.hasFoods ? 1 : 0,
                ),
              ),
            ),
            Center(child: Image.asset(icon, fit: BoxFit.none)),
          ],
        ),
      ),
      title: Text(meal.name, style: Theme.of(context).textTheme.headlineMedium),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.add_circle,
          color: Theme.of(context).colorScheme.primary,
          size: 32,
        ),
      ),
    );
  }
}
