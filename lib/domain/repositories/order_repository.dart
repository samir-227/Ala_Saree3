import '../entities/order.dart';

/// Repository interface for order operations.
/// This defines the contract that data layer must implement.
abstract class OrderRepository {
  /// Places a new order.
  /// Returns the created order with generated ID.
  Future<Order> placeOrder(Order order);

  /// Retrieves all orders.
  /// Returns a list of orders sorted by creation date (newest first).
  Future<List<Order>> getOrders();

  /// Retrieves a specific order by ID.
  /// Throws an exception if order not found.
  Future<Order> getOrderById(String orderId);
}
