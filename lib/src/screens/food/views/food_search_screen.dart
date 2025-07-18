import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_repository/food_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:gulapedia/src/screens/food/blocs/food_search_bloc/food_search_bloc.dart';
import 'package:gulapedia/src/screens/food/views/barcode_scanner_screen.dart';
import 'package:gulapedia/src/utilities/get_sugars_grade.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:gulapedia/src/utilities/format_double_to_string.dart';

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({
    super.key,
    required this.journalId,
    required this.mealId,
    required this.mealName,
  });
  final String journalId;
  final String mealId;
  final String mealName;

  @override
  State<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodSearchBloc>(
      create: (context) => FoodSearchBloc(OpenFoodFactsRepository()),
      child: BlocBuilder<FoodSearchBloc, FoodSearchState>(
        builder: (context, state) {
          return LayoutAppbar(
            title: widget.mealName,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(85),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,

                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Makan apa hari ini?',
                              prefixIcon: Icon(
                                Icons.search,
                                size: 32,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 1.25,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            onSubmitted: (query) {
                              if (query.isNotEmpty) {
                                context.read<FoodSearchBloc>().add(
                                  SearchByQuery(query),
                                );
                              } else {
                                context.read<FoodSearchBloc>().add(
                                  ClearSearch(),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              // Navigate to the barcode scanner screen
                              final String? scannedBarcode =
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BarcodeScannerScreen(),
                                    ),
                                  );

                              if (scannedBarcode != null &&
                                  scannedBarcode.isNotEmpty) {
                                // Dispatch the SearchByBarcode event with the scanned barcode
                                // context.read<FoodSearchBloc>().add(
                                //       SearchByBarcode(scannedBarcode),
                                //     );
                              }
                            },
                            icon: const Icon(
                              Icons.barcode_reader,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationAction: Padding(
              padding: const EdgeInsets.fromLTRB(72, 32, 72, 64),
              child: ElevatedButton(
                onPressed: () {
                  if (state.status == FoodSearchStatus.loaded &&
                      state.selectedFoods.isNotEmpty) {
                    context.pushNamed(
                      RoutesName.konfirmasiMenu,
                      pathParameters: {
                        'journalId': widget.journalId,
                        'mealId': widget.mealId,
                      },
                      queryParameters: {'mealName': widget.mealName},
                      extra: state.selectedFoods,
                    );
                  }
                },
                child: Text(
                  'Simpan ${state.selectedFoods.isNotEmpty ? '(${state.selectedFoods.length})' : ''}',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: Colors.white),
                ),
              ),
            ),
            child: _buildSearchResults(context, state),
          );
        },
      ),
    );
  }

  Widget _buildSearchItem(
    BuildContext context, {
    required Food food,
    required bool isSelected,
  }) {
    final double sugarsTotal = (food.sugars100g / 100) * food.servingSizeGram;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        title: Text(food.name, style: Theme.of(context).textTheme.bodyLarge),
        subtitle: getSugarGrade(sugarsTotal),
        tileColor: Colors.white,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                '${formatDoubleToString(sugarsTotal)} g',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<FoodSearchBloc>().add(ToggleFoodSelection(food));
              },
              icon: isSelected
                  ? Icon(
                      Icons.check_circle_outline,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : const Icon(
                      Icons.add_circle_outline,
                      size: 32,
                      color: Colors.black,
                    ),
            ),
          ],
        ),
        onTap: () => context.pushNamed(RoutesName.makanan, extra: food),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, FoodSearchState state) {
    switch (state.status) {
      case FoodSearchStatus.initial:
        return const Center(child: Text('Mulai cari makanan!'));
      case FoodSearchStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case FoodSearchStatus.failure:
        return Center(
          child: Text('Error: ${state.errorMessage ?? "Terjadi kesalahan"}'),
        );
      case FoodSearchStatus.loaded:
        if (state.results == null || state.results!.isEmpty) {
          return const Center(child: Text('Tidak ada hasil pencarian.'));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Grade', style: Theme.of(context).textTheme.bodyLarge),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.info, size: 22, color: Colors.black),
                ),
                SizedBox(width: 8),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                'Hasil Pencarian',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: state.results!.length,
                itemBuilder: (context, index) {
                  final food = state.results![index];

                  final isSelected = state.selectedFoods.contains(food);

                  return _buildSearchItem(
                    context,
                    food: food,
                    isSelected: isSelected,
                  );
                },
              ),
            ),
          ],
        );
    }
  }
}
