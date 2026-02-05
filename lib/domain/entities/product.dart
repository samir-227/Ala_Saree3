enum ProductType { drink, food }

class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    this.category,
    List<String>? availableSizes,
  }) : _availableSizes = availableSizes;

  final String id;
  final String image;
  final String name;
  final String description;
  final String price;
  final String? category;
  final ProductType type;
  final List<String>? _availableSizes;

  List<String> get availableSizes {
    if (_availableSizes != null) return _availableSizes;
    return type == ProductType.drink
        ? const ['S', 'M', 'L']
        : const ['Regular', 'Large', 'Extra Large'];
  }

  double? get priceValue => double.tryParse(price);

  String get cartId => '${type.name}:$name:$image:$price';
}
