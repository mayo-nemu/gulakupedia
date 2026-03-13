part of 'package:gulapedia/src/screens/journal/views/catatan_harian_screen.dart';

class MealCard extends StatelessWidget {
  const MealCard({
    super.key,
    required this.journal,
    required this.meals,
    this.sugarsTotal = 0,
    this.sugarsGoal = 30,
  });
  final Journal journal;
  final double? sugarsTotal;
  final double? sugarsGoal;
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
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MealItem(
              icon: 'assets/icons/noto_bread.png',
              onPressed: () {
                context.pushNamed(
                  RoutesName.asupan,
                  pathParameters: {'journalId': journal.id},
                  queryParameters: {'mealName': breakfast.name},
                  extra: {'sugarsGoal': sugarsGoal, 'sugarsTotal': sugarsTotal},
                );
              },
              meal: breakfast,
            ),
            Divider(color: const Color.fromARGB(217, 217, 217, 217)),
            MealItem(
              icon: 'assets/icons/noto_pot-of-food.png',
              onPressed: () {
                context.pushNamed(
                  RoutesName.asupan,
                  pathParameters: {'journalId': journal.id},
                  queryParameters: {'mealName': lunch.name},
                  extra: {'sugarsGoal': sugarsGoal, 'sugarsTotal': sugarsTotal},
                );
              },
              meal: lunch,
            ),
            Divider(color: Color.fromARGB(217, 217, 217, 217)),
            MealItem(
              icon: 'assets/icons/noto_green-salad.png',
              onPressed: () {
                context.pushNamed(
                  RoutesName.asupan,
                  pathParameters: {'journalId': journal.id},
                  queryParameters: {'mealName': dinner.name},
                  extra: {'sugarsGoal': sugarsGoal, 'sugarsTotal': sugarsTotal},
                );
              },
              meal: dinner,
            ),
            Divider(color: Color.fromARGB(217, 217, 217, 217)),
            MealItem(
              icon: 'assets/icons/noto_kiwi-fruit.png',
              onPressed: () {
                context.pushNamed(
                  RoutesName.asupan,
                  pathParameters: {'journalId': journal.id},
                  queryParameters: {'mealName': snack.name},
                  extra: {'sugarsGoal': sugarsGoal, 'sugarsTotal': sugarsTotal},
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

  //Tambahan++++++++++++++++++
  // String get foodNames {
  //   if (!meal.hasFoods) return 'Belum ada Asupan';
  //   return meal.meal
  //   .map((food) => food.name)
  //   .take(2)
  //   .join(', ');
  // }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 13,
        bottom: 13,
      ),
      leading: SizedBox(
        height: 55,
        width: 55,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: 55,
                width: 55,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  value: meal.hasFoods ? 1 : 0,
                  strokeWidth: 5,
                ),
              ),
            ),
            Center(
              child: Image.asset(
                icon,
                height: 21,
                width: 21,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      title: Text(meal.name, style: Theme.of(context).textTheme.headlineMedium),
      //Subtitle ini tambahan+++++++++++++
      // subtitle: Text(
      //   foodNames,
      //   style: Theme.of(
      //     context,
      //   ).textTheme.bodySmall?.copyWith(color: Colors.grey),
      //   maxLines: 1,
      //   overflow: TextOverflow.ellipsis,
      // ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.add_circle,
          color: Theme.of(context).colorScheme.primary,
          size: 34,
        ),
      ),
    );
  }
}
