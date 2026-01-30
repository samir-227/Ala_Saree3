
class Food {
  const Food({
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
}
