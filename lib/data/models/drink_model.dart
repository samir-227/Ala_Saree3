import '../../domain/entities/drink.dart';

class DrinkModel {
  DrinkModel({
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
  final double? rightOffset;
  final double? leftOffset;

  String get cartId => 'drink:$name:$image:$price';

  Drink toEntity() {
    return Drink(
      id: id,
      image: image,
      name: name,
      title: title,
      price: price,
      category: category,
      availableSizes: availableSizes,
      height: height,
      leftOffset: leftOffset,
      rightOffset: rightOffset,
    );
  }
}
