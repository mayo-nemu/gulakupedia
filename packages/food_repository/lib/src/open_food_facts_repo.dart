import 'package:food_repository/src/food_repo.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:journal_repository/journal_repository.dart';

import 'dart:developer';

class OpenFoodFactsRepository extends FoodRepository {
  OpenFoodFactsRepository();

  Food? _productToFood(Product product) {
    final double servingSize = product.servingSize != null
        ? double.tryParse(
                product.servingSize!.replaceAll(RegExp(r'[^0-9.]'), ''),
              ) ??
              0.0
        : 0.0;
    final double calories100g =
        product.nutriments?.getValue(
          Nutrient.energyKCal,
          PerSize.oneHundredGrams,
        ) ??
        0.0;
    final double protein100g =
        product.nutriments?.getValue(
          Nutrient.proteins,
          PerSize.oneHundredGrams,
        ) ??
        0.0;
    final double fat100g =
        product.nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ??
        0.0;
    final double sugars100g =
        product.nutriments?.getValue(
          Nutrient.sugars,
          PerSize.oneHundredGrams,
        ) ??
        0.0;

    if (product.barcode == null ||
        product.productName == null ||
        product.productName!.isEmpty ||
        servingSize == 0.0) {
      // This checks for 0.0 sugars
      log(
        'Skipping product due to missing  essential data: ${product.productName ?? product.barcode}',
      );
      return null;
    }

    return Food(
      id: product.barcode ?? '',
      name: product.productName ?? 'N/A',
      servingSizeGram: servingSize,
      calories100g: calories100g,
      protein100g: protein100g,
      fat100g: fat100g,
      sugars100g: sugars100g,
      quantityGram: servingSize,
    );
  }

  // In open_food_facts_repo.dart

  @override
  Future<List<Food>> getFoodsByBarcode(String barcode) async {
    try {
      final ProductQueryConfiguration configuration = ProductQueryConfiguration(
        barcode,
        fields: [
          ProductField.BARCODE,
          ProductField.NAME,
          ProductField.NUTRIMENTS,
          ProductField.SERVING_SIZE,
        ],
        version: ProductQueryVersion.v3,
      );

      final ProductResultV3 result = await OpenFoodAPIClient.getProductV3(
        configuration,
      );

      if (result.status == 'success' && result.product != null) {
        final Food? food = _productToFood(result.product!);
        if (food != null) {
          return [food];
        } else {
          log(
            'Product found for barcode $barcode but could not be converted to Food due to missing/zero data.',
          );
          return [];
        }
      } else {
        log(
          'No product found for barcode: $barcode or API call was not successful.',
        );
        return [];
      }
    } catch (e, st) {
      log('Error finding food by barcode: $e', stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<List<Food>> getFoodsByName(String foodName) async {
    try {
      final ProductSearchQueryConfiguration configuration =
          ProductSearchQueryConfiguration(
            parametersList: [
              SearchTerms(terms: [foodName]),
              PageSize(size: 25),
            ],
            language: OpenFoodFactsLanguage.ENGLISH,
            fields: [
              ProductField.BARCODE,
              ProductField.NAME,
              ProductField.NUTRIMENTS,
              ProductField.SERVING_SIZE,
            ],
            version: ProductQueryVersion.v3,
          );

      final SearchResult result = await OpenFoodAPIClient.searchProducts(
        User(userId: '', password: ''),
        configuration,
      );

      if (result.products != null) {
        return result.products!
            .map((product) {
              return _productToFood(product);
            })
            .whereType<Food>()
            .toList();
      } else {
        return [];
      }
    } catch (e, st) {
      log('Error finding food: $e', stackTrace: st);
      rethrow;
    }
  }
}
