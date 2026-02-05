import 'package:ala_saree3/domain/entities/product_filters.dart';

class ProductFilterService {
  static List<T> filterProducts<T>({
    required List<T> items,
    required ProductFilters filters,
    required String Function(T) nameGetter,
    required String Function(T) descriptionGetter,
    required double? Function(T) priceGetter,
    required String? Function(T) categoryGetter,
    required List<String> Function(T) sizesGetter,
  }) {
    var list = items;

    final q = filters.searchQuery.trim().toLowerCase();

    if (q.isNotEmpty) {
      list = list.where((item) {
        return nameGetter(item).toLowerCase().contains(q) ||
            descriptionGetter(item).toLowerCase().contains(q);
      }).toList();
    }

    if (filters.priceMin != null) {
      list = list.where((item) {
        final p = priceGetter(item);
        return p != null && p >= filters.priceMin!;
      }).toList();
    }

    if (filters.priceMax != null) {
      list = list.where((item) {
        final p = priceGetter(item);
        return p != null && p <= filters.priceMax!;
      }).toList();
    }

    if (filters.category != null && filters.category!.isNotEmpty) {
      list = list
          .where((item) => categoryGetter(item) == filters.category)
          .toList();
    }

    if (filters.size != null && filters.size!.isNotEmpty) {
      list = list
          .where((item) => sizesGetter(item).contains(filters.size))
          .toList();
    }

    return list;
  }
}
