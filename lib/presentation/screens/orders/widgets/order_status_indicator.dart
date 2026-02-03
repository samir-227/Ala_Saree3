import 'package:flutter/material.dart';

import '../../../../domain/entities/order_status.dart';

/// Widget displaying the order status with a visual indicator.
class OrderStatusIndicator extends StatelessWidget {
  const OrderStatusIndicator({super.key, required this.status});

  final OrderStatus status;

  /// Gets the color for the order status.
  Color _getStatusColor(OrderStatus status, ColorScheme colorScheme) {
    switch (status) {
      case OrderStatus.pending:
        return colorScheme.tertiary;
      case OrderStatus.preparing:
        return colorScheme.primary;
      case OrderStatus.delivering:
        return colorScheme.secondary;
      case OrderStatus.completed:
        return colorScheme.tertiaryContainer;
      case OrderStatus.cancelled:
        return colorScheme.error;
    }
  }

  /// Gets the icon for the order status.
  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.pending_outlined;
      case OrderStatus.preparing:
        return Icons.restaurant_outlined;
      case OrderStatus.delivering:
        return Icons.local_shipping_outlined;
      case OrderStatus.completed:
        return Icons.check_circle_outline;
      case OrderStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusColor = _getStatusColor(status, colorScheme);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor.withOpacity(0.3), width: 2),
      ),
      color: statusColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getStatusIcon(status),
                color: colorScheme.onPrimary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Status',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status.label,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
