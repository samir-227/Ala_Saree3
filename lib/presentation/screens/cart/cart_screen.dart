import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_router.dart';
import '../../controller/cart_provider.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/cart_total_footer.dart';
import 'widgets/empty_cart_widget.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: const Text(
          'Your Cart',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: colorScheme.surfaceContainerLow,
      body:
          items.isEmpty
              ? const EmptyCartWidget()
              : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return CartItemCard(
                    item: item,
                    onRemove: () => cart.removeFromCart(item),
                  );
                },
              ),
      bottomNavigationBar: CartTotalFooter(
        totalPrice: cart.totalPrice,
        onCheckout: () => context.push(AppRouter.checkout),
        isEnabled: items.isNotEmpty,
      ),
    );
  }
}
