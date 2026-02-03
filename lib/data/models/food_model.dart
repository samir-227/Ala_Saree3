import '../../domain/entities/food.dart';

class FoodModel {
  FoodModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    this.category,
    this.availableSizes = const ['Regular', 'Large', 'Extra Large'],
  });

  final String id;
  final String image;
  final String name;
  final String description;
  final String price; 
  final String? category;
  final List<String> availableSizes;

  String get cartId => 'food:$name:$image:$price';

  Food toEntity() {
    return Food(
      id: id,
      image: image,
      name: name,
      description: description,
      price: price,
      category: category,
      availableSizes: availableSizes,
    );
  }
}
