import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mcdonald_test/presentation/screens/cart/cart_screen.dart';

import '../../../core/routing/app_router.dart';
import '../drinks/drink_menu_screen.dart';
import '../food/food_menu_screen.dart';
import '../orders/orders_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.initialTabIndex});

  final int? initialTabIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    // Use initialTabIndex if provided, otherwise default to 0
    currentIndex = widget.initialTabIndex?.clamp(0, 2) ?? 0;
  }

  final screens =  [
    DrinksMenuScreen(), // Drinks
    FoodMenuScreen(), // Food
    OrdersScreen(), // Orders
    CartScreen(), // Cart
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          currentIndex: currentIndex.clamp(0, 2),
          onTap: (index) {
            if (index == 3) {
              context.push(AppRouter.cart);
              return;
            }
            setState(() => currentIndex = index);
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: colorScheme.onSurfaceVariant,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedFontSize: 14,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      currentIndex == 0
                          ? colorScheme.primaryContainer
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.local_cafe, size: 20),
              ),
              label: 'Drinks',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      currentIndex == 1
                          ? colorScheme.primaryContainer
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.fastfood, size: 20),
              ),
              label: 'Food',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      currentIndex == 2
                          ? colorScheme.primaryContainer
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.receipt_long, size: 20),
              ),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset('assets/cart.png', width: 20, height: 20),
              ),
              label: 'Cart',
            ),
          ],
        ),
      ),
    );
  }
}
