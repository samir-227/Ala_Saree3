import '../../presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/cart/cart_screen.dart';
import '../../domain/entities/drink.dart';
import '../../domain/entities/food.dart';
import '../../presentation/screens/checkout/add_address_screen.dart';
import '../../presentation/screens/checkout/add_card_screen.dart';
import '../../presentation/screens/checkout/checkout_screen.dart';
import '../../presentation/screens/drinks/drink_details_screen.dart';
import '../../presentation/screens/food/food_details_screen.dart';
import '../../presentation/screens/main_screen/main_screen.dart';

/// Centralized app routing using go_router.
class AppRouter {
  AppRouter._();
  static const splash = '/';
  static const main = '/main';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const addCard = '/checkout/add-card';
  static const addAddress = '/checkout/add-address';
  static const drinkDetails = '/drinks/details';
  static const foodDetails = '/foods/details';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: main,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: cart,
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: addCard,
        builder: (context, state) => const AddCardScreen(),
      ),
      GoRoute(
        path: addAddress,
        builder: (context, state) => const AddAddressScreen(),
      ),
      GoRoute(
        path: drinkDetails,
        builder: (context, state) {
          final drink = state.extra as Drink;
          return DrinkDetails(drink: drink);
        },
      ),
      GoRoute(
        path: foodDetails,
        builder: (context, state) {
          final food = state.extra as Food;
          return FoodDetailsScreen(food: food);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri}'),
      ),
    ),
  );
}

