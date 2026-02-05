import 'package:ala_saree3/core/widgets/app_header.dart';
import 'package:ala_saree3/core/widgets/loading_indicator.dart';
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
      backgroundColor: colorScheme.surfaceContainerLow,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              title: 'My Orders',
              trailing:
                  orderProvider.isLoading
                      ? const LoadingIndicator()
                      : IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () => orderProvider.fetchOrders(),
                        tooltip: 'Refresh',
                      ),
            ),
            Expanded(child: _buildBody(orderProvider, colorScheme)),
          ],
        ),
      ),
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
