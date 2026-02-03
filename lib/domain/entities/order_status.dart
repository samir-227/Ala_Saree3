/// Enum representing the status of an order.
enum OrderStatus { pending, preparing, delivering, completed, cancelled }

extension OrderStatusExtension on OrderStatus {
  /// Returns a human-readable label for the order status.
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.delivering:
        return 'Delivering';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  /// Returns a color code for the order status (for UI).
  /// This is a simple representation - in production, use Theme colors.
  String get colorCode {
    switch (this) {
      case OrderStatus.pending:
        return '#FFA726'; // Orange
      case OrderStatus.preparing:
        return '#42A5F5'; // Blue
      case OrderStatus.delivering:
        return '#66BB6A'; // Green
      case OrderStatus.completed:
        return '#26A69A'; // Teal
      case OrderStatus.cancelled:
        return '#EF5350'; // Red
    }
  }
}
