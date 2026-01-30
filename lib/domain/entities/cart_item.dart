import 'cart_product.dart';


class CartItem {
  CartItem({
    required this.product,
    required this.sizeLabel,
    required this.quantity,
  });

  final CartProduct product;
  final String sizeLabel;
  int quantity;

  double get unitPrice => double.tryParse(product.price) ?? 0;

  double get totalPrice => unitPrice * quantity;
}
