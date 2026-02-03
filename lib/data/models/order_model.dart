import '../../domain/entities/order.dart';
import '../../domain/entities/order_status.dart';
import 'cart_item.dart' as model;
import 'cart_product.dart';

/// Data model for Order.
/// Handles conversion between domain entities and data models.
class OrderModel {
  OrderModel({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.orderStatus,
    required this.createdAt,
  });

  final String id;
  final List<model.CartItem> items;
  final double totalPrice;
  final OrderStatus orderStatus;
  final DateTime createdAt;

  /// Converts this model to a domain entity.
  Order toEntity() {
    return Order(
      id: id,
      items: items.map((item) => item.toEntity()).toList(),
      totalPrice: totalPrice,
      orderStatus: orderStatus,
      createdAt: createdAt,
    );
  }

  /// Creates a model from a domain entity.
  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      items:
          order.items.map((item) {
            // Convert CartItem entity to CartItem model
            return model.CartItem(
              product: CartProduct(
                id: item.product.id,
                name: item.product.name,
                image: item.product.image,
                price: item.product.price,
                type: item.product.type,
              ),
              sizeLabel: item.sizeLabel,
              quantity: item.quantity,
            );
          }).toList(),
      totalPrice: order.totalPrice,
      orderStatus: order.orderStatus,
      createdAt: order.createdAt,
    );
  }

  /// Converts model to JSON for storage (if needed in future).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items':
          items
              .map(
                (item) => {
                  'product': {
                    'id': item.product.id,
                    'name': item.product.name,
                    'image': item.product.image,
                    'price': item.product.price,
                    'type': item.product.type,
                  },
                  'sizeLabel': item.sizeLabel,
                  'quantity': item.quantity,
                },
              )
              .toList(),
      'totalPrice': totalPrice,
      'orderStatus': orderStatus.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Creates model from JSON (if needed in future).
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      items:
          (json['items'] as List)
              .map(
                (item) => model.CartItem(
                  product: CartProduct(
                    id: item['product']['id'] as String,
                    name: item['product']['name'] as String,
                    image: item['product']['image'] as String,
                    price: item['product']['price'] as String,
                    type: item['product']['type'] as String,
                  ),
                  sizeLabel: item['sizeLabel'] as String,
                  quantity: item['quantity'] as int,
                ),
              )
              .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      orderStatus: OrderStatus.values.firstWhere(
        (status) => status.name == json['orderStatus'],
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
