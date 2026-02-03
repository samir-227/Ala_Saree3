import 'dart:math';

import '../../domain/entities/order.dart';
import '../../domain/entities/order_status.dart';
import '../../domain/repositories/order_repository.dart' as domain;
import '../models/order_model.dart';

/// Implementation of OrderRepository using in-memory storage.
/// In production, this would use a database or API.
class OrderRepositoryImpl implements domain.OrderRepository {
  OrderRepositoryImpl() : _orders = <OrderModel>[];

  // In-memory storage for orders
  final List<OrderModel> _orders;
  final Random _random = Random();

  /// Generates a unique order ID.
  String _generateOrderId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = _random.nextInt(10000);
    return 'ORD-$timestamp-$random';
  }

  @override
  Future<Order> placeOrder(Order order) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Generate ID if not provided
    final orderId = order.id.isEmpty ? _generateOrderId() : order.id;

    // Create order with generated ID and pending status
    final newOrder = Order(
      id: orderId,
      items: order.items,
      totalPrice: order.totalPrice,
      orderStatus: OrderStatus.pending,
      createdAt: DateTime.now(),
    );

    // Convert to model and store
    final orderModel = OrderModel.fromEntity(newOrder);
    _orders.insert(0, orderModel); // Insert at beginning for newest first

    return newOrder;
  }

  @override
  Future<List<Order>> getOrders() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Return orders sorted by creation date (newest first)
    final sortedOrders = List<OrderModel>.from(_orders)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return sortedOrders.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Order> getOrderById(String orderId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final orderModel = _orders.firstWhere(
      (order) => order.id == orderId,
      orElse: () => throw Exception('Order not found: $orderId'),
    );

    return orderModel.toEntity();
  }
}
