import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:gulapedia/src/screens/meal/blocs/meal_bloc.dart';
import 'package:gulapedia/src/screens/meal/widgets/food_list.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:journal_repository/journal_repository.dart';

part 'package:gulapedia/src/screens/meal/widgets/nutrition_list.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({
    super.key,
    required this.journalId,
    required this.mealName,
    required this.sugarsGoal,
    required this.sugarsTotal,
  });

  final String mealName;
  final String journalId;
  final double sugarsGoal;
  final double sugarsTotal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealBloc, MealState>(
      builder: (context, state) {
        if (state is MealLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MealFailure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else if (state is MealSuccess) {
          Meal meal = state.meal;
          String icon = 'assets/icons/noto_bread.png';
          if (meal.name == 'Asupan Pagi') {
            icon = 'assets/icons/noto_bread.png';
          } else if (meal.name == 'Asupan Siang') {
            icon = 'assets/icons/noto_pot-of-food.png';
          } else if (meal.name == 'Asupan Malam') {
            icon = 'assets/icons/noto_green-salad.png';
          } else if (meal.name == 'Cemilan') {
            icon = 'assets/icons/noto_kiwi-fruit.png';
          }
          return LayoutAppbar(
            title: meal.name,
            back: () => context.goNamed(RoutesName.catatanHarian),
            bottomNavigationAction: Padding(
              padding: const EdgeInsets.only(left: 72, right: 72, bottom: 64),
              child: ElevatedButton(
                onPressed: () => context.pushNamed(
                  RoutesName.tambahMenu,
                  pathParameters: {'journalId': journalId, 'mealId': meal.id},
                  queryParameters: {'mealName': mealName},
                  extra: {'sugarsGoal': sugarsGoal, 'sugarsTotal': sugarsTotal},
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 24,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Tambah menu',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            height: 96,
                            width: 96,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.secondary,
                              value: meal.hasFoods
                                  ? meal.totalSugarsGram / sugarsGoal
                                  : 0,
                              strokeWidth: 8,
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: 96,
                            width: 96,
                            child: Image.asset(
                              icon,
                              height: 56,
                              width: 56,
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '${meal.totalSugarsGram.toStringAsFixed(2)} / ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextSpan(
                            text: sugarsGoal.toStringAsFixed(2),
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 56),
                    state.foods.isEmpty
                        ? SizedBox.shrink()
                        : FoodList(foods: state.foods),
                    NutritionList(meal: meal),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
