import 'package:flutter/material.dart';
import 'package:mcdonald_test/components/quantity_selector.dart';
import 'package:mcdonald_test/core/utils/app_snackbar.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/drink.dart';
import '../../controller/cart_provider.dart';
import '../../controller/drinks_provider.dart';
import '../../controller/product_details_provider.dart';
import 'widgets/add_to_cart_button.dart';
import 'widgets/product_header.dart';
import 'widgets/product_image_carousel.dart';
import 'widgets/size_selector.dart';

class DrinkDetails extends StatefulWidget {
  const DrinkDetails({super.key, required this.drink});

  final Drink drink;

  @override
  State<DrinkDetails> createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
  late PageController _pageController;
  final ProductDetailsProvider _detailsProvider = ProductDetailsProvider();
  double _currentPage = 0;
  List<Drink> _drinks = [];

  @override
  void initState() {
    super.initState();

    // 1. Get the list of drinks immediately (using read, not watch)
    // We only need this ONCE to find our starting point.
    _drinks = context.read<DrinksProvider>().drinks;

    // 2. Find where to start
    int initialIndex = _drinks.indexWhere((d) => d.id == widget.drink.id);
    if (initialIndex == -1) initialIndex = 0;

    // 3. Update our state tracker
    _currentPage = initialIndex.toDouble();

    // 4. Create the controller starting at the right place!
    _pageController = PageController(
      viewportFraction: 0.65,
      initialPage: initialIndex,
    );

    // 5. Listen for future swipes
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
    if (_drinks.isEmpty) return;

    final errorMessage = _detailsProvider.validateBeforeAddToCart();

    if (errorMessage != null) {
      AppSnackBar.showError(context, message: errorMessage);
      return;
    }

    final currentIndex = _currentPage.round().clamp(0, _drinks.length - 1);
    final selectedDrink = _drinks[currentIndex];
    final selectedSizeLabel = _detailsProvider.selectedSizeLabel!;

    final cartProduct = _detailsProvider.createCartProduct(
      id: selectedDrink.cartId,
      name: selectedDrink.name,
      image: selectedDrink.image,
      price: selectedDrink.price,
      type: 'drink',
    );

    context.read<CartProvider>().addToCart(
      product: cartProduct,
      sizeLabel: selectedSizeLabel,
      quantity: _detailsProvider.quantity,
    );

    AppSnackBar.showSuccess(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (_drinks.isEmpty) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final currentIndex = _currentPage.round().clamp(0, _drinks.length - 1);
    final currentDrink = _drinks[currentIndex];

    return ChangeNotifierProvider.value(
      value: _detailsProvider,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Stack(
          children: [
            Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: ProductHeader(
                name: currentDrink.name,
                title: currentDrink.title,
                price: currentDrink.price,
              ),
            ),
            ProductImageCarousel(
              images: _drinks.map((d) => d.image).toList(),
              pageController: _pageController,
              currentPage: _currentPage,
              drinkSize: 1.1,
              translateMultiplier: 100,
              shadowAsset: 'assets/drinks/Ellipse 2.png',
              shadowBottomPosition: 175,
              imageHeight: 1000,
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 16,
              child: Consumer<ProductDetailsProvider>(
                builder: (context, provider, _) {
                  return Column(
                    children: [
                      SizeSelector(
                        sizeLabels: ProductDetailsProvider.drinkSizeLabels,
                        selectedIndex: provider.selectedSizeIndex,
                        onSizeSelected: provider.selectSize,
                        useIcon: true,
                      ),
                      QuantitySelector(
                        quantity: provider.quantity,
                        onChanged: provider.setQuantity,
                      ),
                      AddToCartButton(
                        onPressed: _onAddToCart,
                        enabled: provider.canAddToCart,
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
