import 'cart_item.dart';
import 'order_status.dart';

/// Domain entity representing an order.
/// This is the core business entity - no UI dependencies.
class Order {
  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.orderStatus,
    required this.createdAt,
  });

  /// Unique identifier for the order.
  final String id;

  /// List of items in the order.
  final List<CartItem> items;

  /// Total price of the order.
  final double totalPrice;

  /// Current status of the order.
  final OrderStatus orderStatus;

  /// Timestamp when the order was created.
  final DateTime createdAt;

  /// Creates a copy of this order with updated fields.
  Order copyWith({
    String? id,
    List<CartItem>? items,
    double? totalPrice,
    OrderStatus? orderStatus,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      orderStatus: orderStatus ?? this.orderStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
