import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/drinks_repository.dart';
import 'data/repositories/foods_repository.dart';
import 'data/repositories/order_repository.dart';
import 'presentation/controller/cart_provider.dart';
import 'presentation/controller/drinks_provider.dart';
import 'presentation/controller/foods_provider.dart';
import 'presentation/controller/order_provider.dart';

void main() {
  runApp(const AlaSaree3());
}

class AlaSaree3 extends StatelessWidget {
  const AlaSaree3({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency injection: Create repository implementations
    final drinksRepository = DrinksRepositoryImpl();
    final foodsRepository = FoodsRepositoryImpl();
    final orderRepository = OrderRepositoryImpl();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) => DrinksProvider(repository: drinksRepository)..loadDrinks(),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(
          create:
              (_) => FoodsProvider(repository: foodsRepository)..loadFoods(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(repository: orderRepository),
        ),
      ],
      child: MaterialApp.router(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light, 
        debugShowCheckedModeBanner: false,
        title: 'Ala Saree3',
        routerConfig: AppRouter.router,
      ),
    );
  }
}
