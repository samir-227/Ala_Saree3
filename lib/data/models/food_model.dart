import '../../domain/entities/food.dart';


class FoodModel {
  FoodModel({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  });

  final String image;
  final String name;
  final String description;
  final String price;

  String get cartId => 'food:$name:$image:$price';

  Food toEntity() {
    return Food(
      image: image,
      name: name,
      description: description,
      price: price,
    );
  }
}
