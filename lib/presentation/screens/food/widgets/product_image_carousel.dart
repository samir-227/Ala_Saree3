import 'package:flutter/material.dart';

class ProductImageCarousel extends StatelessWidget {
  const ProductImageCarousel({
    super.key,
    required this.images,
    required this.pageController,
    required this.currentPage,
    this.viewportFraction = 0.5,
    this.scaleBase = 1.1,
    this.translateMultiplier = 400.0,
    this.shadowAsset,
    this.shadowHeight,
    this.shadowMargin,
  });

  final List<String> images;
  final PageController pageController;
  final double currentPage;
  final double viewportFraction;
  final double scaleBase;
  final double translateMultiplier;
  final String? shadowAsset;
  final double? shadowHeight;
  final EdgeInsets? shadowMargin;

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.height * 0.55;

    return PageView.builder(
      controller: pageController,
      itemCount: images.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final scale = scaleBase - (currentPage - index).abs() * 1;
        final translateY = (currentPage - index).abs() * translateMultiplier;

        return Transform.translate(
          offset: Offset(translateY, 0),
          child: Transform.scale(
            scale: scale.clamp(0.5, 1.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  images[index],
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
                if (shadowAsset != null)
                  Positioned(
                    bottom: shadowHeight ?? 160,
                    right: 0,
                    left: 0,
                    child: Image.asset(shadowAsset!),
                  )
                else if (shadowMargin != null)
                  Positioned(
                    bottom: shadowHeight ?? 140,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 18,
                      margin: shadowMargin!,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 40,
                            spreadRadius: 4,
                            color: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.38),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}