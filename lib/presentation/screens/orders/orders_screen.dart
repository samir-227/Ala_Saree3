import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_router.dart';
import '../../controller/order_provider.dart';
import 'widgets/empty_orders_widget.dart';
import 'widgets/order_item_card.dart';

/// Screen displaying the list of all orders.
/// Shows order history with status, date, and total price.
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch orders when screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: const Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          if (orderProvider.isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => orderProvider.fetchOrders(),
              tooltip: 'Refresh',
            ),
        ],
      ),
      backgroundColor: colorScheme.surfaceContainerLow,
      body: _buildBody(orderProvider, colorScheme),
    );
  }

  Widget _buildBody(OrderProvider orderProvider, ColorScheme colorScheme) {
    if (orderProvider.isLoading && orderProvider.orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orderProvider.error != null && orderProvider.orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(
              orderProvider.error!,
              style: TextStyle(color: colorScheme.error),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => orderProvider.fetchOrders(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (!orderProvider.hasOrders) {
      return const EmptyOrdersWidget();
    }

    return RefreshIndicator(
      onRefresh: () => orderProvider.fetchOrders(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, index) {
          final order = orderProvider.orders[index];
          return OrderItemCard(
            order: order,
            onTap: () {
              context.push('${AppRouter.orderDetails}/${order.id}');
            },
          );
        },
      ),
    );
  }
}
