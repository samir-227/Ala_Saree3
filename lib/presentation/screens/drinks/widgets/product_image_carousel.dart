import 'package:flutter/material.dart';

class ProductImageCarousel extends StatelessWidget {
  const ProductImageCarousel({
    super.key,
    required this.images,
    required this.pageController,
    required this.currentPage,
    this.viewportFraction = 0.5,
    this.drinkSize = 1.1,
    this.translateMultiplier = 400.0,
    this.shadowAsset,
    this.shadowBottomPosition = 200,
    this.imageHeight = 900,
  });

  final List<String> images;
  final PageController pageController;
  final double currentPage;
  final double viewportFraction;
  final double drinkSize;
  final double translateMultiplier;
  final String? shadowAsset;
  final double shadowBottomPosition;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: images.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final scale = drinkSize - (currentPage - index).abs() * 1;
        final translateY = (currentPage - index).abs() * translateMultiplier;
        
        return Transform.translate(
          offset: Offset(translateY, 0),
          child: Transform.scale(
            scale: scale.clamp(0.5, 1.0),
            child: Stack(
              children: [
                Image.asset(
                  images[index],
                  height: imageHeight,
                ),
                if (shadowAsset != null)
                  Positioned(
                    bottom: shadowBottomPosition,
                    right: 0,
                    left: 0,
                    child: Image.asset(shadowAsset!),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}