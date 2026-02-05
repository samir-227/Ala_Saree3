import 'package:flutter/foundation.dart';

import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart' as domain;

/// Provider for managing order state.
class OrderProvider extends ChangeNotifier {
  OrderProvider({required domain.OrderRepository repository})
    : _repository = repository;

  final domain.OrderRepository _repository;

  List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;

  /// List of all orders (read-only).
  List<Order> get orders => List.unmodifiable(_orders);

  /// Whether orders are currently being fetched.
  bool get isLoading => _isLoading;

  /// Error message if an operation failed.
  String? get error => _error;

  /// Whether there are any orders.
  bool get hasOrders => _orders.isNotEmpty;

  /// Places a new order from the cart items.
  /// Returns the created order on success.
  Future<Order?> placeOrder(Order order) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final createdOrder = await _repository.placeOrder(order);
      _orders.insert(0, createdOrder); // Add to beginning for newest first
      _isLoading = false;
      notifyListeners();
      return createdOrder;
    } catch (e) {
      _error = 'Failed to place order: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Fetches all orders from the repository.
  Future<void> fetchOrders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await _repository.getOrders();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to fetch orders: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Retrieves a specific order by ID.
  /// Returns null if not found.
  Future<Order?> getOrderById(String orderId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final order = await _repository.getOrderById(orderId);
      _isLoading = false;
      notifyListeners();
      return order;
    } catch (e) {
      _error = 'Order not found: $orderId';
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Clears the error state.
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
