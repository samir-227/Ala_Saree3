import '../entities/product.dart';

abstract class DrinksRepository {
  Future<List<ProductEntity>> getDrinks();
}
