import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ala_saree3/domain/entities/drink_filters.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_router.dart';
import '../../../core/widgets/drink_card.dart';
import '../../../core/widgets/filter_bottom_sheet.dart';
import '../../../core/widgets/menu_search_bar.dart';
import '../../controller/drinks_provider.dart';
import '../../controller/product_details_provider.dart';
import 'widgets/animated_list_item.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/menu_header.dart';

class DrinksMenuScreen extends StatefulWidget {
  const DrinksMenuScreen({super.key});

  @override
  State<DrinksMenuScreen> createState() => _DrinksMenuScreenState();
}

class _DrinksMenuScreenState extends State<DrinksMenuScreen> {
  final ScrollController _scrollController = ScrollController();
  static const double itemHeight = 160;
  static const double _maxPrice = 50;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openFilterSheet(BuildContext context) {
    final provider = context.read<DrinksProvider>();
    final f = provider.filters;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => FilterBottomSheet(
            categories: provider.categories,
            sizes: ProductDetailsProvider.drinkSizeLabels,
            initialPriceMin: f.priceMin ?? 0,
            initialPriceMax: f.priceMax ?? _maxPrice,
            initialCategory: f.category,
            initialSize: f.size,
            maxPrice: _maxPrice,
            onApply: (result) {
              provider.setFilters(
                DrinkFilters(
                  searchQuery: f.searchQuery,
                  priceMin: result.priceMin,
                  priceMax: result.priceMax,
                  category: result.category,
                  size: result.size,
                ),
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final drinksProvider = context.watch<DrinksProvider>();
    final drinks = drinksProvider.filteredDrinks;
    final filters = drinksProvider.filters;

    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            MenuHeader(
              title: 'Drinks',
              trailing: IconButton(
                onPressed: () => _openFilterSheet(context),
                icon: const Icon(Icons.tune),
                tooltip: 'Filters',
              ),
            ),
            MenuSearchBar(
              value: filters.searchQuery,
              onChanged: drinksProvider.setSearchQuery,
              hint: 'Search drinks...',
            ),
            Expanded(
              child:
                  drinksProvider.isLoading && drinksProvider.drinks.isEmpty
                      ? const LoadingIndicator(message: 'Loading menu...')
                      : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: drinks.length,
                        itemBuilder: (context, index) {
                          final drink = drinks[index];

                          return AnimatedListItem(
                            scrollController: _scrollController,
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
                                tag: 'drink-${drink.id}',
                                child: DrinkCard(
                                  id: drink.id, 
                                  title: drink.title,
                                  name: drink.name,
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
