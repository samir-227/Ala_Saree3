import 'package:ala_saree3/core/services/product_filter_service.dart';
import 'package:ala_saree3/domain/entities/product_filters.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/foods_repository.dart';

class FoodsProvider extends ChangeNotifier {
  FoodsProvider({required FoodsRepository repository})
    : _repository = repository {
    loadFoods();
  }

  final FoodsRepository _repository;

  final List<ProductEntity> _foods = [];
  List<ProductEntity> get foods => List.unmodifiable(_foods);

  ProductFilters _filters = const ProductFilters();
  ProductFilters get filters => _filters;

  /// Filtered list based on search and filter state.
  List<ProductEntity> get filteredFoods {
    return ProductFilterService.filterProducts(
      items: _foods,
      filters: _filters,
      nameGetter: (d) => d.name,
      descriptionGetter: (d) => d.description,
      priceGetter: (d) => d.priceValue,
      categoryGetter: (d) => d.category,
      sizesGetter: (d) => d.availableSizes,
    );
  }

  List<String> get categories =>
      _foods.map((food) => food.category).whereType<String>().toSet().toList()
        ..sort();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setSearchQuery(String value) {
    if (_filters.searchQuery == value) return;
    _filters = _filters.copyWith(searchQuery: value);
    notifyListeners();
  }

  void setFilters(ProductFilters value) {
    _filters = value;
    notifyListeners();
  }

  void clearFilters() {
    final query = _filters.searchQuery;
    _filters = ProductFilters(searchQuery: query);
    notifyListeners();
  }

  void loadFoods() {
    if (_isLoading || _foods.isNotEmpty) return;

    _isLoading = true;
    notifyListeners();

    _foods
      ..clear()
      ..addAll(_repository.getFoods());

    _isLoading = false;
    notifyListeners();
  }
}
