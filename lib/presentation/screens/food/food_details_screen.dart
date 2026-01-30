import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/toggle_widget.dart';
import '../../../domain/entities/food.dart';
import '../../controller/cart_provider.dart';
import '../../controller/foods_provider.dart';
import '../../controller/product_details_provider.dart';
import 'widgets/add_to_cart_button.dart';
import 'widgets/product_header.dart';
import 'widgets/product_image_carousel.dart';
import 'widgets/size_selector.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key, required this.food});

  final Food food;

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.55);
  final ProductDetailsProvider _detailsProvider = ProductDetailsProvider();
  double _currentPage = 0;
  List<Food> _foods = [];
  bool _initializedPage = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final foodsProvider = context.watch<FoodsProvider>();
    _foods = foodsProvider.foods;

    if (!_initializedPage && _foods.isNotEmpty) {
      final initialIndex = _foods.indexWhere((f) => f.name == widget.food.name);
      final startIndex = initialIndex == -1 ? 0 : initialIndex;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (_pageController.hasClients && !_initializedPage) {
          _pageController.jumpToPage(startIndex);
          setState(() {
            _currentPage = startIndex.toDouble();
          });
          _initializedPage = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _detailsProvider.dispose();
    super.dispose();
  }

  void _onAddToCart() {
    if (_foods.isEmpty) return;

    final errorMessage = _detailsProvider.validateBeforeAddToCart();
    if (errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
      return;
    }

    final currentIndex = _currentPage.round().clamp(0, _foods.length - 1);
    final selectedFood = _foods[currentIndex];
    final sizeLabel = _detailsProvider.selectedSizeLabel!;

    final cartProduct = _detailsProvider.createCartProduct(
      id: selectedFood.cartId,
      name: selectedFood.name,
      image: selectedFood.image,
      price: selectedFood.price,
      type: 'food',
    );

    context.read<CartProvider>().addToCart(
      product: cartProduct,
      sizeLabel: sizeLabel,
      quantity: _detailsProvider.quantity,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (_foods.isEmpty) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final currentIndex = _currentPage.round().clamp(0, _foods.length - 1);
    final currentFood = _foods[currentIndex];

    return ChangeNotifierProvider.value(
      value: _detailsProvider,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: ProductHeader(
                name: currentFood.name,
                description: currentFood.description,
                price: currentFood.price,
              ),
            ),
            ProductImageCarousel(
              images: _foods.map((f) => f.image).toList(),
              pageController: _pageController,
              currentPage: _currentPage,
              viewportFraction: 0.55,
              scaleBase: 1.1,
              translateMultiplier: 100,
              shadowHeight: 140,
              shadowMargin: const EdgeInsets.symmetric(horizontal: 90),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 10,
              child: Consumer<ProductDetailsProvider>(
                builder: (context, provider, _) {
                  return Column(
                    children: [
                      SizeSelector(
                        sizeLabels: ProductDetailsProvider.sizeLabels,
                        selectedIndex: provider.selectedSizeIndex,
                        onSizeSelected: provider.selectSize,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: DrinkToggle()),
                          const SizedBox(width: 40),
                          Expanded(
                            child: QuantitySelector(
                              onChanged: provider.setQuantity,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AddToCartButton(
                        onPressed: _onAddToCart,
                        enabled: provider.canAddToCart,
                      ),
                    ],
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
