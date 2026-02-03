import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class MenuFilterResult {
  const MenuFilterResult({
    this.priceMin,
    this.priceMax,
    this.category,
    this.size,
  });

  final double? priceMin;
  final double? priceMax;
  final String? category;
  final String? size;
}

/// Bottom sheet for filtering menu items by Price, Category, and Size.
/// Callback [onApply] receives the selected filter values.
class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required this.categories,
    required this.sizes,
    required this.initialPriceMin,
    required this.initialPriceMax,
    required this.initialCategory,
    required this.initialSize,
    required this.onApply,
    this.maxPrice = 100,
  });

  final List<String> categories;
  final List<String> sizes;
  final double? initialPriceMin;
  final double? initialPriceMax;
  final String? initialCategory;
  final String? initialSize;
  final ValueChanged<MenuFilterResult> onApply;
  final double maxPrice;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late double _priceMin;
  late double _priceMax;
  String? _category;
  String? _size;

  @override
  void initState() {
    super.initState();
    _priceMin = widget.initialPriceMin ?? 0;
    _priceMax = widget.initialPriceMax ?? widget.maxPrice;
    _category = widget.initialCategory;
    _size = widget.initialSize;
  }

  void _apply() {
    final effectiveMin = _priceMin > 0 ? _priceMin : null;
    final effectiveMax = _priceMax < widget.maxPrice ? _priceMax : null;
    widget.onApply(
      MenuFilterResult(
        priceMin: effectiveMin,
        priceMax: effectiveMax,
        category: _category,
        size: _size,
      ),
    );
    Navigator.of(context).pop();
  }

  void _clear() {
    setState(() {
      _priceMin = 0;
      _priceMax = widget.maxPrice;
      _category = null;
      _size = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: 24 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(onPressed: _clear, child: const Text('Clear all')),
            ],
          ),
          const SizedBox(height: 16),
          // Price
          Text(
            'Price',
            style: theme.textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          RangeSlider(
            values: RangeValues(_priceMin, _priceMax),
            min: 0,
            max: widget.maxPrice,
            divisions: (widget.maxPrice ~/ 5).clamp(1, 50),
            activeColor: AppColors.tertiary,
            onChanged: (v) {
              setState(() {
                _priceMin = v.start;
                _priceMax = v.end;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              '\$${_priceMin.toStringAsFixed(0)} – \$${_priceMax.toStringAsFixed(0)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          // Category
          if (widget.categories.isNotEmpty) ...[
            Text(
              'Category',
              style: theme.textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  widget.categories.map((c) {
                    final selected = _category == c;
                    return FilterChip(
                      label: Text(c),
                      selected: selected,
                      onSelected: (v) {
                        setState(() {
                          _category = v ? c : null;
                        });
                      },
                      selectedColor: AppColors.tertiary.withValues(alpha: 0.3),
                      checkmarkColor: AppColors.tertiary,
                    );
                  }).toList(),
            ),
            const SizedBox(height: 16),
          ],
          // Size
          if (widget.sizes.isNotEmpty) ...[
            Text(
              'Size',
              style: theme.textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  widget.sizes.map((s) {
                    final selected = _size == s;
                    return FilterChip(
                      label: Text(s),
                      selected: selected,
                      onSelected: (v) {
                        setState(() {
                          _size = v ? s : null;
                        });
                      },
                      selectedColor: AppColors.tertiary.withValues(alpha: 0.3),
                      checkmarkColor: AppColors.tertiary,
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
          ],
          FilledButton(
            onPressed: _apply,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.tertiary,
              foregroundColor: colorScheme.onTertiary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('Apply filters'),
          ),
        ],
      ),
    );
  }
}
