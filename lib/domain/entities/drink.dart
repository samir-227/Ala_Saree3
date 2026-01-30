
class Drink {
  const Drink({
    required this.image,
    required this.name,
    required this.title,
    required this.price,
    this.height,
    this.leftOffset,
    this.rightOffset,
  });

  final String image;
  final String name;
  final String title;
  final String price;
  final double? height;
  final double? leftOffset;
  final double? rightOffset;

  String get cartId => 'drink:$name:$image:$price';
}
