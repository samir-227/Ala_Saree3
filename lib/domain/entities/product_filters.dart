/// Filter state for drinks menu (search + price/category/size).
class ProductFilters {
  const ProductFilters({
    this.searchQuery = '',
    this.priceMin,
    this.priceMax,
    this.category,
    this.size,
  });

  final String searchQuery;
  final double? priceMin;
  final double? priceMax;
  final String? category;
  final String? size;

  ProductFilters copyWith({
    String? searchQuery,
    double? priceMin,
    double? priceMax,
    String? category,
    String? size,
  }) {
    return ProductFilters(
      searchQuery: searchQuery ?? this.searchQuery,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      category: category ?? this.category,
      size: size ?? this.size,
    );
  }
}
