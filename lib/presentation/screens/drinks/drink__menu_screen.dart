import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_router.dart';
import '../../../core/widgets/drink_card.dart';
import '../../controller/drinks_provider.dart';
import 'widgets/animated_list_item.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/menu_header.dart';

/// Screen for displaying drinks menu.
/// UI-only screen - all logic is in providers.
class DrinksMenuScreen extends StatefulWidget {
  const DrinksMenuScreen({super.key});

  @override
  State<DrinksMenuScreen> createState() => _DrinksMenuScreenState();
}

class _DrinksMenuScreenState extends State<DrinksMenuScreen> {
  final ScrollController _controller = ScrollController();
  static const double itemHeight = 160;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drinksProvider = context.watch<DrinksProvider>();
    final drinks = drinksProvider.drinks;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const MenuHeader(),
            const SizedBox(height: 16),
            Expanded(
              child:
                  drinksProvider.isLoading && drinks.isEmpty
                      ? const LoadingIndicator(message: 'Loading menu...')
                      : ListView.builder(
                        controller: _controller,
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: drinks.length,
                        itemBuilder: (context, index) {
                          final drink = drinks[index];

                          return AnimatedListItem(
                            scrollController: _controller,
                            index: index,
                            itemHeight: itemHeight,
                            opacityMultiplier: 0.5,
                            scaleMultiplier: 0.15,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                context.push(
                                  AppRouter.drinkDetails,
                                  extra: drink,
                                );
                              },
                              child: Hero(
                                tag: 'drink-$index',
                                child: DrinkCard(
                                  name: drink.name,
                                  title: drink.title,
                                  image: drink.image,
                                  price: drink.price,
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
