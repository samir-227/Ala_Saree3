import 'package:flutter/material.dart';
import '../drinks/drink__menu_screen.dart';

import '../food/food_menu_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final screens = const [
    DrinksMenuScreen(), // Drinks
    FoodMenuScreen(), // Food
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
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
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
          ],
        ),
      ),
    );
  }
}
