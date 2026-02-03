import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          child: Container(
            padding:
                useIcon
                    ? const EdgeInsets.all(11)
                    : const EdgeInsets.symmetric(horizontal: 8),
            constraints: useIcon ? null : const BoxConstraints(minWidth: 44),
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: useIcon ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: useIcon ? null : BorderRadius.circular(22),
              color: isSelected ? colorScheme.tertiary : colorScheme.surface,
              border: Border.all(
                color:
                    isSelected ? colorScheme.tertiary : colorScheme.onSurface,
              ),
            ),
            child:
                useIcon
                    ? SvgPicture.asset(
                      'assets/Vector.svg',
                      color:
                          isSelected
                              ? colorScheme.onTertiary
                              : colorScheme.onSurface,
                    )
                    : FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        sizeLabels[index],
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          color:
                              isSelected
                                  ? colorScheme.onTertiary
                                  : colorScheme.onSurface,
                        ),
                      ),
                    ),
          ),
        );
      }),
    );
  }
}
