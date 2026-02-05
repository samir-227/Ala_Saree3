import 'package:ala_saree3/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
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

  final screens = [
    DrinksMenuScreen(), // Drinks
    FoodMenuScreen(), // Food
    OrdersScreen(), // Orders

    ProfileScreen(),
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
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex.clamp(0, 3),
            onTap: (index) {
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
                    color:
                        currentIndex == 3
                            ? colorScheme.primaryContainer
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.person, size: 20),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
