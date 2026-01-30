import '../../domain/entities/drink.dart';


class DrinkModel {
  DrinkModel({
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
  final double? rightOffset;
  final double? leftOffset;

  String get cartId => 'drink:$name:$image:$price';

  Drink toEntity() {
    return Drink(
      image: image,
      name: name,
      title: title,
      price: price,
      height: height,
      leftOffset: leftOffset,
      rightOffset: rightOffset,
    );
  }
}
