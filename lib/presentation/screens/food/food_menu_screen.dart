import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_router.dart';
import '../../../core/widgets/food_card.dart';
import '../../controller/foods_provider.dart';
import 'widgets/animated_list_item.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/menu_header.dart';

/// Screen for displaying food menu.
/// UI-only screen - all logic is in providers.
class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  final ScrollController _controller = ScrollController();
  static const double itemHeight = 160;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodsProvider = context.watch<FoodsProvider>();
    final foods = foodsProvider.foods;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const MenuHeader(),
            const SizedBox(height: 16),
            Expanded(
              child: foodsProvider.isLoading && foods.isEmpty
                  ? const LoadingIndicator(message: 'Loading menu...')
                  : ListView.builder(
                      controller: _controller,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        final food = foods[index];

                        return AnimatedListItem(
                          scrollController: _controller,
                          index: index,
                          itemHeight: itemHeight,
                          opacityMultiplier: 0.5,
                          scaleMultiplier: 0.2,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              context.push(
                                AppRouter.foodDetails,
                                extra: food,
                              );
                            },
                            child: Hero(
                              tag: 'food-$index',
                              child: FoodCard(
                                image: food.image,
                                name: food.name,
                                description: food.description,
                                price: food.price,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
