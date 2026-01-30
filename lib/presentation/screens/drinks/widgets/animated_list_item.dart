import 'package:flutter/material.dart';

/// Reusable widget for animated list items with scroll-based animations.
/// UI-only widget with no business logic.
class AnimatedListItem extends StatelessWidget {
  const AnimatedListItem({
    super.key,
    required this.scrollController,
    required this.index,
    required this.itemHeight,
    required this.child,
    this.opacityMultiplier = 0.5,
    this.scaleMultiplier = 0.15,
  });

  final ScrollController scrollController;
  final int index;
  final double itemHeight;
  final Widget child;
  final double opacityMultiplier;
  final double scaleMultiplier;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, _) {
        double offset = 0;
        if (scrollController.hasClients) {
          offset = (scrollController.offset / itemHeight) - index;
        }
        offset = offset.clamp(0.0, 1.0);

        return Opacity(
          opacity: 1 - (offset * opacityMultiplier),
          child: Transform.scale(
            scale: 1 - (offset * scaleMultiplier),
            child: child,
          ),
        );
      },
    );
  }
}
