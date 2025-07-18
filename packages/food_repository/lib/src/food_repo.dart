import 'package:journal_repository/journal_repository.dart';

abstract class FoodRepository {
  Future<List<Food>> getFoodsByName(String foodName);
  Future<List<Food>> getFoodsByBarcode(String barcode);
}
