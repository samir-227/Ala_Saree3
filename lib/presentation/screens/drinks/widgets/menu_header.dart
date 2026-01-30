import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';

/// Reusable widget for menu screen header with title and cart icon.
/// UI-only widget with no business logic.
class MenuHeader extends StatelessWidget {
  const MenuHeader({
    super.key,
    this.title = 'Menu',
    this.onCartTap,
  });

  final String title;
  final VoidCallback? onCartTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onCartTap ?? () => context.push(AppRouter.cart),
            child: Image.asset('assets/cart.png', width: 26),
          ),
        ],
      ),
    );
  }
}
