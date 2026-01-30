import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/toggle_widget.dart';
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
  final PageController _pageController = PageController(viewportFraction: 0.50);
  final ProductDetailsProvider _detailsProvider = ProductDetailsProvider();
  double _currentPage = 0;
  List<Drink> _drinks = [];
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
    final drinksProvider = context.watch<DrinksProvider>();
    _drinks = drinksProvider.drinks;

    if (!_initializedPage && _drinks.isNotEmpty) {
      final initialIndex = _drinks.indexWhere(
        (d) => d.name == widget.drink.name,
      );
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
    if (_drinks.isEmpty) return;

    final errorMessage = _detailsProvider.validateBeforeAddToCart();

    if (errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
      return;
    }

    final currentIndex = _currentPage.round().clamp(0, _drinks.length - 1);
    final selectedDrink = _drinks[currentIndex];
    final sizeLabel = _detailsProvider.selectedSizeLabel!;

    final cartProduct = _detailsProvider.createCartProduct(
      id: selectedDrink.cartId,
      name: selectedDrink.name,
      image: selectedDrink.image,
      price: selectedDrink.price,
      type: 'drink',
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
              shadowBottomPosition: 180,
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
                        sizeLabels: ProductDetailsProvider.sizeLabels,
                        selectedIndex: provider.selectedSizeIndex,
                        onSizeSelected: provider.selectSize,
                        useIcon: true,
                      ),
                      const SizedBox(height: 16),
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
