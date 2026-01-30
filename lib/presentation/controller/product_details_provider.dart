import 'package:flutter/foundation.dart';

import '../../domain/entities/cart_product.dart';

/// Provider for managing product details state (size, quantity, etc.).
/// Business logic lives here, not in UI widgets.
class ProductDetailsProvider extends ChangeNotifier {
  static const List<String> sizeLabels = ['S', 'M', 'L', 'XL'];

  int? _selectedSizeIndex;
  int? get selectedSizeIndex => _selectedSizeIndex;

  String? get selectedSizeLabel =>
      _selectedSizeIndex != null ? sizeLabels[_selectedSizeIndex!] : null;

  int _quantity = 1;
  int get quantity => _quantity;

  double _currentPage = 0;
  double get currentPage => _currentPage;

  void selectSize(int index) {
    if (index >= 0 && index < sizeLabels.length) {
      _selectedSizeIndex = index;
      notifyListeners();
    }
  }

  void setQuantity(int value) {
    if (value > 0) {
      _quantity = value;
      notifyListeners();
    }
  }

  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void setCurrentPage(double page) {
    _currentPage = page;
    notifyListeners();
  }

  bool get canAddToCart => _selectedSizeIndex != null;

  /// Validates that a size is selected before adding to cart.
  /// Returns error message if validation fails, null if valid.
  String? validateBeforeAddToCart() {
    if (_selectedSizeIndex == null ||
        _selectedSizeIndex! < 0 ||
        _selectedSizeIndex! >= sizeLabels.length) {
      return 'Please select a size';
    }
    return null;
  }

  /// Creates a CartProduct from the selected product.
  CartProduct createCartProduct({
    required String id,
    required String name,
    required String image,
    required String price,
    required String type,
  }) {
    return CartProduct(
      id: id,
      name: name,
      image: image,
      price: price,
      type: type,
    );
  }

  void reset() {
    _selectedSizeIndex = null;
    _quantity = 1;
    _currentPage = 0;
    notifyListeners();
  }
}
