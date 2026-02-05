import 'package:ala_saree3/core/widgets/animated_list_item.dart';
import 'package:ala_saree3/core/widgets/product_card.dart';
import 'package:ala_saree3/core/widgets/loading_indicator.dart';
import 'package:ala_saree3/core/widgets/app_header.dart';
import 'package:ala_saree3/domain/entities/product_filters.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/filter_bottom_sheet.dart';
import '../../../core/widgets/menu_search_bar.dart';
import '../../controller/foods_provider.dart';
import '../../controller/product_details_provider.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  final ScrollController _controller = ScrollController();
  static const double itemHeight = 160;
  static const double _maxPrice = 25;

  void _openFilterSheet(BuildContext context) {
    final provider = context.read<FoodsProvider>();
    final f = provider.filters;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (ctx) => FilterBottomSheet(
            categories: provider.categories,
            sizes: ProductDetailsProvider.foodSizeLabels,
            initialPriceMin: f.priceMin ?? 0,
            initialPriceMax: f.priceMax ?? _maxPrice,
            initialCategory: f.category,
            initialSize: f.size,
            maxPrice: _maxPrice,
            onApply: (result) {
              provider.setFilters(
                ProductFilters(
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodsProvider = context.watch<FoodsProvider>();
    final foods = foodsProvider.filteredFoods;
    final filters = foodsProvider.filters;

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              title: 'Food',
              trailing: IconButton(
                onPressed: () => _openFilterSheet(context),
                icon: const Icon(Icons.tune),
                tooltip: 'Filters',
              ),
            ),
            MenuSearchBar(
              value: filters.searchQuery,
              onChanged: foodsProvider.setSearchQuery,
              hint: 'Search food...',
            ),
            Expanded(
              child:
                  foodsProvider.isLoading && foodsProvider.foods.isEmpty
                      ? const LoadingIndicator()
                      : ListView.builder(
                        controller: _controller,
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
                                tag: 'food-${food.id}',
                                child: ProductCard(
                                  id: food.id,
                                  image: food.image,
                                  name: food.name,
                                  title: food.description,
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
