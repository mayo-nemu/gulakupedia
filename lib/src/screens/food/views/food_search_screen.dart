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

  void _showGradeInfo(BuildContext context) {
    final grades = [
      {
        'g': 'A',
        'r': '≤ 5g',
        'l': 'Sangat Rendah',
        'c': const Color(0xFF28C76F),
      },
      {'g': 'B', 'r': '5 - 10g', 'l': 'Rendah', 'c': const Color(0xFFA3CB38)},
      {'g': 'C', 'r': '10 - 15g', 'l': 'Sedang', 'c': const Color(0xFFFFA500)},
      {'g': 'D', 'r': '≥ 15g', 'l': 'Tinggi', 'c': const Color(0xFFFF4C4C)},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: const Center(child: Text('Kategori Kandungan Gula')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: grades
              .map(
                (data) => _buildGradeLine(
                  context,
                  data['g'] as String,
                  data['r'] as String,
                  data['l'] as String,
                  data['c'] as Color,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
      builder: (context, state) {
        return LayoutAppbar(
          title: widget.mealName,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(89),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(21, 21, 21, 21),
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
                            hintText: 'Cari Asupan',
                            prefixIcon: Icon(
                              Icons.search,
                              size: 34,
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
                            Icons.qr_code_scanner_rounded,
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
            padding: const EdgeInsets.fromLTRB(55, 0, 55, 55),
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
      padding: const EdgeInsets.only(bottom: 5),
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
                      size: 34,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : const Icon(
                      Icons.add_circle_outline,
                      size: 34,
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
        return const Center(child: Text('Mulai cari Nutrisi!'));
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
                  const SizedBox(height: 13),
                  Text(
                    'Barcode: ${widget.barcode}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 21),
                  const Text(
                    'Coba cari dengan nama makanan atau scan barcode lain.',
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Tidak ada hasil pencarian.'));
        }
        return ListView.builder(
          itemCount: state.results!.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 21),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Grade',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      IconButton(
                        onPressed: () => _showGradeInfo(context),
                        icon: const Icon(
                          Icons.info,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 21),
                    child: Text(
                      'Hasil Pencarian',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }

            final food = state.results![index - 1];
            final isSelected = state.selectedFoods.contains(food);

            return _buildSearchItem(
              context,
              food: food,
              isSelected: isSelected,
            );
          },
        );
    }
  }
}

Widget _buildGradeLine(
  BuildContext context,
  String letter,
  String range,
  String label,
  Color color,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.5),
    child: Text.rich(
      TextSpan(
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
            text: '$letter  :  $range ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ).copyWith(color: color),
          ),
          TextSpan(text: ' — $label'),
        ],
      ),
    ),
  );
}
