import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Reusable widget for selecting product size.
/// UI-only widget with no business logic.
class SizeSelector extends StatelessWidget {
  const SizeSelector({
    super.key,
    required this.sizeLabels,
    required this.selectedIndex,
    required this.onSizeSelected,
    this.useIcon = false,
  });

  final List<String> sizeLabels;
  final int? selectedIndex;
  final ValueChanged<int> onSizeSelected;
  final bool useIcon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(sizeLabels.length, (index) {
        final isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () => onSizeSelected(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: useIcon ? const EdgeInsets.all(11) : null,
                width: useIcon ? null : 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? colorScheme.tertiary : colorScheme.surface,
                  border: Border.all(
                    color: isSelected ? colorScheme.tertiary : colorScheme.onSurface,
                  ),
                ),
                child: useIcon
                    ? SvgPicture.asset(
                        'assets/Vector.svg',
                        color: isSelected ? colorScheme.onTertiary : colorScheme.onSurface,
                      )
                    : Text(
                        sizeLabels[index],
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? colorScheme.onTertiary : colorScheme.onSurface,
                        ),
                      ),
              ),
              const SizedBox(height: 6),
              Text(
                sizeLabels[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                  color: isSelected ? colorScheme.tertiary : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
