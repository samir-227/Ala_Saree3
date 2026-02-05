import '../../domain/entities/product.dart';

class Product extends ProductEntity {
  const Product({
    required super.id,
    required super.image,
    required super.name,
    required super.description,
    required super.price,
    required super.type,
    super.category,
    super.availableSizes,
  });

  ProductEntity toEntity() {
    return this;
  }
}
