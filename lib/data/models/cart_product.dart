import '../../domain/entities/cart_product.dart' as domain;


class CartProduct {
  CartProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.type,
  });

  final String id;

  final String name;
  final String image;
  final String price;

  final String type;

  domain.CartProduct toEntity() {
    return domain.CartProduct(
      id: id,
      name: name,
      image: image,
      price: price,
      type: type,
    );
  }
}

