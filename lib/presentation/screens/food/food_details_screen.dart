import 'package:flutter/material.dart';
import 'package:mcdonald_test/components/quantity_selector.dart';
import 'package:mcdonald_test/core/utils/app_snackbar.dart';
import 'package:provider/provider.dart';

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
  late PageController _pageController;
  final ProductDetailsProvider _detailsProvider = ProductDetailsProvider(
    sizeLabels: ProductDetailsProvider.foodSizeLabels,
  );
  double _currentPage = 0;
  List<Food> _foods = [];

  @override
  void initState() {
    super.initState();
    _foods = context.read<FoodsProvider>().foods;

    int initialIndex = _foods.indexWhere((f) => f.id == widget.food.id);
    if (initialIndex != -1) initialIndex = 0;

    _currentPage = initialIndex.toDouble();
    _pageController = PageController(
      viewportFraction: .65,
      initialPage: initialIndex,
    );
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
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
      AppSnackBar.showError(context, message: errorMessage);
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

    AppSnackBar.showSuccess(context);
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
              translateMultiplier: 65,
              shadowHeight: 185,
              shadowMargin: const EdgeInsets.symmetric(horizontal: 90),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 10,
              child: Consumer<ProductDetailsProvider>(
                builder: (context, detailsProvider, _) {
                  return Column(
                    children: [
                      SizeSelector(
                        sizeLabels: ProductDetailsProvider.foodSizeLabels,
                        selectedIndex: detailsProvider.selectedSizeIndex,
                        onSizeSelected: detailsProvider.selectSize,
                      ),
                      QuantitySelector(
                        quantity: detailsProvider.quantity,
                        onChanged: detailsProvider.setQuantity,
                      ),
                      AddToCartButton(
                        onPressed: _onAddToCart,
                        enabled: detailsProvider.canAddToCart,
                      ),
                      const SizedBox(height: 16),
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
