import '../entities/product.dart';

abstract class FoodsRepository {
  List<ProductEntity> getFoods();
}
