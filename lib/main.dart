import 'package:ala_saree3/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/controller/cart_provider.dart';
import 'presentation/controller/drinks_provider.dart';
import 'presentation/controller/foods_provider.dart';
import 'presentation/controller/order_provider.dart';
import 'presentation/controller/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const AlaSaree3());
}

class AlaSaree3 extends StatelessWidget {
  const AlaSaree3({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<ThemeProvider>()),
        ChangeNotifierProvider(
          create: (_) => sl<DrinksProvider>()..loadDrinks(),
        ),
        ChangeNotifierProvider(create: (_) => sl<CartProvider>()),
        ChangeNotifierProvider(create: (_) => sl<FoodsProvider>()..loadFoods()),
        ChangeNotifierProvider(create: (_) => sl<OrderProvider>()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp.router(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            title: 'Ala Saree3',
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
