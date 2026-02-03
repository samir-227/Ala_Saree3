class Drink {
  const Drink({
    required this.id,
    required this.image,
    required this.name,
    required this.title,
    required this.price,
    this.category,
    this.availableSizes = const ['S', 'M', 'L', 'XL'],
    this.height,
    this.leftOffset,
    this.rightOffset,
  });

  final String id;
  final String image;
  final String name;
  final String title;
  final String price;
  final String? category;
  final List<String> availableSizes;
  final double? height;
  final double? leftOffset;
  final double? rightOffset;

  String get cartId => 'drink:$name:$image:$price';

  double? get priceValue => double.tryParse(price);
}
