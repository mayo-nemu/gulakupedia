import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:gulapedia/src/screens/food/blocs/food_save_bloc/food_save_bloc.dart';
import 'package:gulapedia/src/utilities/double_to_string.dart';

class FoodConfirmationScreen extends StatefulWidget {
  const FoodConfirmationScreen({
    super.key,
    required this.journalId,
    required this.mealId,
    required this.mealName,
    required this.sugarsGoal,
    required this.sugarsTotal,
    required this.foods,
  });

  final String journalId;
  final String mealId;
  final String mealName;
  final double sugarsGoal;
  final double sugarsTotal;
  final List<Food> foods;

  @override
  State<FoodConfirmationScreen> createState() => _FoodConfirmationScreenState();
}

class _FoodConfirmationScreenState extends State<FoodConfirmationScreen> {
  late String _userId;
  late FoodSaveBloc _foodSaveBloc;

  final Map<String, TextEditingController> _quantityControllers = {};

  @override
  void initState() {
    super.initState();
    _userId = context.read<AuthenticationBloc>().state.user!.userId;
    _foodSaveBloc = context.read<FoodSaveBloc>();

    for (var food in widget.foods) {
      _quantityControllers[food.id] = TextEditingController(
        text: doubleToString(food.quantityGram),
      );
    }
  }

  @override
  void dispose() {
    _quantityControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _updateFoodQuantity(Food food, String value) {
    final newQuantity = double.tryParse(value) ?? food.quantityGram;

    _foodSaveBloc.add(
      FoodQuantityUpdated(
        updatedFood: food.copyWith(quantityGram: newQuantity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodSaveBloc, FoodSaveState>(
      listener: (context, state) {
        if (state.status == FoodSaveStatus.success) {
          context.goNamed(
            RoutesName.asupan,
            pathParameters: {'journalId': widget.journalId},
            queryParameters: {'mealName': widget.mealName},
            extra: {
              'sugarsGoal': widget.sugarsGoal,
              'sugarsTotal': widget.sugarsTotal,
            },
          );
        } else if (state.status == FoodSaveStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save foods: ${state.errorMessage}'),
            ),
          );
        }
      },
      builder: (context, state) {
        return LayoutAppbar(
          title: 'Atur Jumlah Asupan',
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Asupan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ), // "Intake"
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Berat (g)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ), // "Weight (g)"
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Gula (g)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      ), // "Sugar (g)"
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationAction: Padding(
            padding: const EdgeInsets.fromLTRB(72, 0, 72, 64),
            child: ElevatedButton(
              onPressed: () {
                if (widget.foods.isNotEmpty) {
                  context.read<FoodSaveBloc>().add(
                    AddFoodtoMenu(
                      widget.foods,
                      _userId,
                      widget.journalId,
                      widget.mealId,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No foods to save!')),
                  );
                }
              },
              child: Text(
                'Selesai', // "Done"
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: Colors.white),
              ),
            ),
          ),
          child: widget.foods.isEmpty
              ? const Center(
                  child: Text('No foods selected. Go back to search.'),
                )
              : _buildFoodList(context, foods: widget.foods),
        );
      },
    );
  }

  Padding _buildFoodQuantityInput(Food food) {
    final sugarsTotal = (food.sugars100g / 100) * food.quantityGram;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  food.name,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 85,
                  child: TextField(
                    controller: _quantityControllers[food.id],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) => _updateFoodQuantity(food, value),
                    decoration: InputDecoration(
                      isDense: true, // Reduce vertical space
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ), // Adjust padding
                      border: OutlineInputBorder(
                        // Add border
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // Rounded corners
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${doubleToString(sugarsTotal)} g',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildFoodList(BuildContext context, {required List<Food> foods}) {
    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final thisFood = foods[index];
        if (!_quantityControllers.containsKey(thisFood.id)) {
          _quantityControllers[thisFood.id] = TextEditingController(
            text: doubleToString(thisFood.quantityGram),
          );
        } else {
          // Update controller text if quantityGram changed from external source
          final currentText = _quantityControllers[thisFood.id]!.text;
          final newQuantityText = doubleToString(thisFood.quantityGram);
          if (currentText != newQuantityText) {
            _quantityControllers[thisFood.id]!.text = newQuantityText;
            _quantityControllers[thisFood.id]!.selection =
                TextSelection.fromPosition(
                  TextPosition(offset: newQuantityText.length),
                );
          }
        }
        return _buildFoodQuantityInput(thisFood);
      },
    );
  }
}
