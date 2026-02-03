import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:gulapedia/src/screens/food/blocs/food_search_bloc/food_search_bloc.dart';
import 'package:gulapedia/src/utilities/get_sugars_grade.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:gulapedia/src/utilities/double_to_string.dart';

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({
    super.key,
    required this.journalId,
    required this.mealId,
    required this.mealName,
    this.barcode,
    required this.sugarsGoal,
    required this.sugarsTotal,
  });

  final String journalId;
  final String mealId;
  final String mealName;
  final String? barcode;
  final double sugarsGoal;
  final double sugarsTotal;

  @override
  State<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  late FoodSearchBloc _foodSearchBloc;
  bool _lastSearchWasByBarcode = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foodSearchBloc = context.read<FoodSearchBloc>();

    if (widget.barcode != null) {
      _foodSearchBloc.add(SearchByBarcode(widget.barcode));
      _searchController.text = widget.barcode!;
      _lastSearchWasByBarcode = true;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
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
                              _lastSearchWasByBarcode = false;
                            } else {
                              context.read<FoodSearchBloc>().add(ClearSearch());
                              _lastSearchWasByBarcode = false;
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
                            context.pushReplacementNamed(
                              RoutesName.scanBarcode,
                              pathParameters: {
                                'journalId': widget.journalId,
                                'mealId': widget.mealId,
                              },
                              queryParameters: {'mealName': widget.mealName},
                              extra: {
                                'sugarsGoal': widget.sugarsGoal,
                                'sugarsTotal': widget.sugarsTotal,
                              },
                            );
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
                    extra: {
                      'sugarsGoal': widget.sugarsGoal,
                      'sugarsTotal': widget.sugarsTotal,
                      'foods': state.selectedFoods,
                    },
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
                '${doubleToString(sugarsTotal)} g',
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
          if (_lastSearchWasByBarcode && widget.barcode != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tidak ada hasil untuk barcode ini.'),
                  const SizedBox(height: 10),
                  Text(
                    'Barcode: ${widget.barcode}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Coba cari dengan nama makanan atau scan barcode lain.',
                  ),
                ],
              ),
            );
          }
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Untuk menilai kualitas nutrisi,\ntermasuk kandungan gula.',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  ),
                                ],
                              ),
                              Text.rich(
                                TextSpan(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: [
                                    TextSpan(text: '•    Grade '),
                                    TextSpan(
                                      text: 'A : ≤ 5g',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Color(0xFF28C76F)),
                                    ),
                                    TextSpan(text: ' Gula Sangat Rendah'),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: [
                                    TextSpan(text: '•    Grade '),
                                    TextSpan(
                                      text: 'B : 5g - 10g',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Color(0xFFA3CB38)),
                                    ),
                                    TextSpan(text: ' Gula Rendah'),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: [
                                    TextSpan(text: '•    Grade '),
                                    TextSpan(
                                      text: 'C : 10g - 15g',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Color(0xFFFFA500)),
                                    ),
                                    TextSpan(text: ' Gula Sedang'),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: [
                                    TextSpan(text: '•    Grade '),
                                    TextSpan(
                                      text: 'D : ≥ 15g',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Color(0xFFFF4C4C)),
                                    ),
                                    TextSpan(text: ' Gula Tinggi'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
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
