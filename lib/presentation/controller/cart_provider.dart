import 'package:flutter/foundation.dart';

import '../../domain/entities/cart_item.dart';
import '../../domain/entities/cart_product.dart';

/// Provider for managing cart state.
/// Business logic lives here, not in UI widgets.
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addToCart({
    required CartProduct product,
    required String sizeLabel,
    required int quantity,
  }) {
    // If same product and size already exists, just increase quantity.
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id && item.sizeLabel == sizeLabel,
    );

    if (existingIndex != -1) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(
        CartItem(product: product, sizeLabel: sizeLabel, quantity: quantity),
      );
    }

    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
